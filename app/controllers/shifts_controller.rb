class ShiftsController < ApplicationController
  include Calendar
  before_filter :recur
  def index
    @shifts = Shift.order(:shiftstart)
    @hours_per_person = show_hours_per_person
    @flag = Flag.find_by_id(1)
    Time.zone = "UTC"
    @date_start = @flag.flagstart.to_date
    if !params[:newstart].nil?
      @date_start = params[:newstart].to_date
    end
    @next_seven = @date_start..(@date_start + 6)
    @second_seven = (@date_start + 7)..(@date_start + 13)
  end

  def new
  end

  def show
    @shift = Shift.find params[:id]
  end

  def edit
    @shift = Shift.find params[:id]
  end

  def create
    date = create_date
    l = params[:length]
    @shift = Shift.create(:shiftstart => date, :shiftend => (date + l[:length].to_i.hours).to_datetime)
    @shift.shiftstart = fix_timezone(@shift.shiftstart)
    @shift.shiftend = fix_timezone(@shift.shiftend)
    gcal_event_insert(0, @shift)
    redirect_to shifts_path
  end

  def create_date
    p = params[:s]
    t = params[:time]
    dt = Date.new(p[:"date(1i)"].to_i, p[:"date(2i)"].to_i, p[:"date(3i)"].to_i)
    final_dt = dt + t[:hour].to_i.hour + t[:min].to_i.minute
    return final_dt.to_datetime
  end

  def update
    @shift = Shift.find params[:id]
    date_update = create_date
    l = params[:length]
    s = params[:shift]
    @shift.update_attributes!(:shiftstart => date_update, :shiftend => (date_update+ l[:length].to_i.hours).to_datetime)
    if s[:owner] == "" || s[:owner].nil?
      @shift.update_attribute(:owner, '***')
    else
      @shift.update_attribute(:owner, (User.find_by_first_name(s[:owner]).first_name))
    end
    @shift.shiftstart = fix_timezone(@shift.shiftstart)
    @shift.shiftend = fix_timezone(@shift.shiftend)
    if (!@shift.users.nil? || !@shift.possible_users.nil?) &&(@shift.owner != "***")
      gcal_event_update(User.find_by_first_name(@shift.owner).id, @shift)
    else
      gcal_event_update(0, @shift)
    end
    redirect_to shifts_path
  end

  def destroy
    @shift = Shift.find(params[:id])
    gcal_event_delete(@shift.event_id)
    @shift.destroy
    flash[:notice] = "Shift deleted."
    redirect_to shifts_path
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
        hours_per_person[shift.owner][0] = hours_per_person[shift.owner][0] + ((shift.shiftend - shift.shiftstart)/(60*60)).to_i
      else
        hours_per_person[shift.owner] = [((shift.shiftend - shift.shiftstart)/(60*60)).to_i, 0]      
      end
    end
    return hours_per_person
  end

  def fix_timezone(dt)
      if Time.now.dst?
        return (dt + 6.hours).to_datetime
      else
        return (dt + 7.hours).to_datetime
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
    @shift_1.shiftstart = fix_timezone(@shift_1.shiftstart)
    @shift_1.shiftend = fix_timezone(@shift_1.shiftend)
    gcal_event_insert(0, @shift_1)
    @shift_2 = Shift.create(:shiftstart => (recur_day + 1.week), :shiftend => (day_end + 1.week))
    @shift_2.shiftstart = fix_timezone(@shift_2.shiftstart)
    @shift_2.shiftend = fix_timezone(@shift_2.shiftend)
    gcal_event_insert(0, @shift_2)
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
