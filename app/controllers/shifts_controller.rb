class ShiftsController < ApplicationController
  include Calendar
  def index
    @shifts = Shift.all
    @hours_per_person = show_hours_per_person
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
    @shift = Shift.create!(params[:shift])
    offset = params[:length]
    new_shiftend = @shift.shiftstart + offset[:length].to_i.hours
    @shift.update_attribute(:shiftend, new_shiftend.to_datetime)
    flash[:notice] = "Shift was successfully created."
    dt_start = fix_timezone(@shift.shiftstart)
    dt_end = fix_timezone(@shift.shiftend)
    dt_doc = @shift.owner
    gcal_event_insert(0, dt_doc, "core", dt_start, dt_end, @shift.event_id)
    @shift.ingcal = true
    @shift.save!
    redirect_to shifts_path
  end
  
  def update
    @shift = Shift.find params[:id]
    old_user = @shift.owner
    if old_user == '***' || old_user == ""
      delete_id = 0
    else
      delete_id = User.find_by_first_name(old_user).id
    end
    @shift.update_attributes!(params[:shift])
    dt_start = fix_timezone(@shift.shiftstart)
    dt_end = fix_timezone(@shift.shiftend)
    dt_doc = @shift.owner
    if dt_doc == "" || dt_doc.nil?
      dt_doc = "***"
      @shift.update_attribute(:owner, '***')
    end
    if (!@shift.users.nil? || !@shift.possible_users.nil?) &&(dt_doc != "***")
      gcal_event_update(User.find_by_first_name(dt_doc).id, dt_doc, "core", dt_start, dt_end, @shift.event_id)
    else
      gcal_event_update(0, dt_doc, "core", dt_start, dt_end, @shift.event_id)
    end
    flash[:notice] = "Shift was successfully updated."
    redirect_to shifts_path
  end

  def destroy
    @shift = Shift.find(params[:id])
    if @shift.owner == '***' || @shift.owner == "" || @shift.owner.nil? || @shift.owner == " "
      gcal_event_delete(@shift.event_id)
    else
      dt_doc = @shift.owner
      gcal_event_delete(@shift.event_id)
    end
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
        return (dt + 8.hours).to_datetime
      else
        return (dt + 9.hours).to_datetime
      end
  end
end
