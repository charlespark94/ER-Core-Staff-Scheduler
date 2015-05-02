module ShiftHelper
  def update_helper(date, shift, params)
    l = params[:length]
    s = params[:shift]
    lh = l[:length].to_i
    df = date + lh.hour
    o = s[:owner] if !s.nil?
    user = User.find_by_first_name(o)
    shift.update_attribute(:owner, '***') if o == "" || o.nil?
    shift.update_attribute(:owner, user.first_name) if o != "" && !o.nil?
    shift.update_attribute(:shiftstart, date)
    shift.update_attribute(:shiftend, df.to_datetime)
    shift.shiftstart = fix_timezone_gcal(shift.shiftstart)
    shift.shiftend = fix_timezone_gcal(shift.shiftend)
  end

  def show_hours_per_person
    users = User.all
    hours_per_person = {"***" => [0, 0]}
    users.each do |user|
      full_name = "#{user.first_name}"
      hours_per_person[full_name] = [0, (user.fte*80).to_i]
    end
    shifts = Shift.all
    shifts.each do |shift|
      if hours_per_person.has_key?(shift.owner)
        show_hours_helper(hours_per_person, shift)
      else
        hours_per_person[shift.owner] = [dh.to_i, 0]      
      end
    end
    return hours_per_person
  end

  def show_hours_helper(hp, shift)
    se = shift.shiftend
    ss = shift.shiftstart
    diff = se - ss
    dh = diff/1.hour
    input = hp[shift.owner][0] + dh.to_i
    hp[shift.owner][0] = input
  end


  def fix_timezone_gcal(dt)
      if Time.now.dst?
        return (dt + 6.hours).to_datetime
      else
        return (dt + 7.hours).to_datetime
      end
  end

  def fix_timezone_app(dt)
      if Time.now.dst?
        return (dt - 6.hours).to_datetime
      else
        return (dt - 7.hours).to_datetime
      end
  end

  def recur
    @flag = Flag.find_by_id(1)
    return if check_time(@flag)
    @shift_template = IO.read("public/shift_template.json")
    @shift_pattern = JSON.parse(@shift_template)
    cur_sunday = @flag.flagstart + 2.week
    counter = 0
    @shift_pattern.each do |cur_pattern|
      if !cur_pattern.nil?
        for key in cur_pattern         
          recur_day_gen(key, cur_sunday, counter)
        end
      end
      counter += 1
    end
    flag_update_helper(@flag)
  end

  def recur_day_gen(key, cur_sunday, counter)
    rd = cur_sunday + counter.day + key[1][0].hour + key[1][1].minute
    de = rd + key[1][2].hours
    recur_helper(rd, de)
  end

  def recur_helper(recur_day, day_end)
    @shift_1 = Shift.create(:shiftstart => recur_day, :shiftend =>day_end)
    @shift_1.shiftstart = fix_timezone_gcal(@shift_1.shiftstart)
    @shift_1.shiftend = fix_timezone_gcal(@shift_1.shiftend)
    gcal_event_insert(0, @shift_1)
    @shift_1.shiftstart = fix_timezone_app(@shift_1.shiftstart)
    @shift_1.shiftend = fix_timezone_app(@shift_1.shiftend)
    @shift_2 = Shift.create(:shiftstart => (recur_day + 1.week), :shiftend => (day_end + 1.week))
    @shift_2.shiftstart = fix_timezone_gcal(@shift_2.shiftstart)
    @shift_2.shiftend = fix_timezone_gcal(@shift_2.shiftend)
    gcal_event_insert(0, @shift_2)
    @shift_2.shiftstart = fix_timezone_app(@shift_2.shiftstart)
    @shift_2.shiftend = fix_timezone_app(@shift_2.shiftend)
  end

  def check_time(flag)
    t = Time.current - 7.hours
    f = flag.flagstart
    diff = t.to_date - f.to_date
    flag.update_attribute(:recurring, true) if !@flag.recurring if diff.to_i < 14
    return diff.to_i < 14
  end

  def flag_update_helper(flag)
    flag.update_attribute(:recurring, false)
    t = Time.current
    w = t.wday
    sun = t - w.day
    flag.update_attribute(:flagstart, sun.to_date)
  end
end
