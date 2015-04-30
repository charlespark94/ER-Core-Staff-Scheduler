class ShiftsController < ApplicationController
  include Calendar
  before_filter :recur
  def index
    @shifts = Shift.order(:shiftstart)
    @hours_per_person = show_hours_per_person
    @flag = Flag.find_by_id(1)
    Time.zone = "UTC"
    #Time.zone = "America/Los_Angeles"
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
    date = DateTime.new(params[:shift][:"date(1i)"].to_i, params[:shift][:"date(2i)"].to_i, params[:shift][:"date(3i)"].to_i, params[:shift][:hour].to_i, params[:shift][:min].to_i)
    @shift = Shift.create(:shiftstart => date, :shiftend => (date + params[:length][:length].to_i.hours).to_datetime)
    gcal_event_insert(0, @shift.owner, "core", fix_timezone(@shift.shiftstart), fix_timezone(@shift.shiftend), @shift.event_id)
    @shift.ingcal = true
    @shift.save!
    redirect_to shifts_path
  end
  
  def update
    @shift = Shift.find params[:id]
    date = DateTime.new(params[:shift][:"shiftstart(1i)"].to_i, params[:shift][:"shiftstart(2i)"].to_i, params[:shift][:"shiftstart(3i)"].to_i, params[:time][:hour].to_i, params[:time][:min].to_i)
    @shift.update_attributes!(:shiftstart => date, :shiftend => (date + params[:length][:length].to_i.hours).to_datetime)
    dt_start = fix_timezone(@shift.shiftstart)
    dt_end = fix_timezone(@shift.shiftend)
    dt_doc = params[:shift][:owner]
    if dt_doc == "" || dt_doc.nil?
      dt_doc = "***"
      @shift.update_attribute(:owner, '***')
    else
      @shift.update_attribute(:owner, (User.find_by_first_name(params[:shift][:owner]).first_name) 
    end
    if (!@shift.users.nil? || !@shift.possible_users.nil?) &&(dt_doc != "***")
      gcal_event_update(User.find_by_first_name(dt_doc).id, dt_doc, "core", dt_start, dt_end, @shift.event_id)
    else
      gcal_event_update(0, dt_doc, "core", dt_start, dt_end, @shift.event_id)
    end
    redirect_to shifts_path
  end

  def destroy
    @shift = Shift.find(params[:id])
    #if @shift.owner == '***' || @shift.owner == "" || @shift.owner.nil? || @shift.owner == " "
    gcal_event_delete(@shift.event_id)
    #else
    #  dt_doc = @shift.owner
    #  gcal_event_delete(@shift.event_id)
    #end
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
    if ((Time.current - 7.hours).to_date - @flag.flagstart.to_date).to_i >= 14
      if @flag.recurring
        @shift_template = IO.read("public/shift_template.json")
        @shift_pattern = JSON.parse(@shift_template)
        cur_sunday = @flag.flagstart + 2.week
        counter = 0
        @shift_pattern.each do |cur_pattern|
          if !cur_pattern.nil?
            for key in cur_pattern
              recur_day = cur_sunday + counter.day + key[1][0].hour + key[1][1].minute
              day_end = recur_day + key[1][2].hours
              @shift_1 = Shift.create(:shiftstart => recur_day, :shiftend =>day_end)
              gcal_event_insert(0, @shift_1.owner, "core", fix_timezone(@shift_1.shiftstart), fix_timezone(@shift_1.shiftend), @shift_1.event_id)
              @shift_1.update_attribute(:ingcal, true)
              @shift_2 = Shift.create(:shiftstart => (recur_day + 1.week), :shiftend => (day_end + 1.week))
              gcal_event_insert(0, @shift_2.owner, "core", fix_timezone(@shift_2.shiftstart), fix_timezone(@shift_2.shiftend), @shift_2.event_id)
              @shift_2.update_attribute(:ingcal, true)
            end
          end
          counter += 1
        end
        @flag.update_attribute(:recurring, false)
        @flag.update_attribute(:flagstart, (Time.current - Time.current.wday.day).to_date)
      end
    else
      @flag.update_attribute(:recurring, true) if !@flag.recurring
    end
  end
end
