class ShiftsController < ApplicationController
  include Calendar
  include ShiftHelper
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
    @shift.shiftstart = fix_timezone_gcal(@shift.shiftstart)
    @shift.shiftend = fix_timezone_gcal(@shift.shiftend)
    gcal_event_insert(0, @shift)
    @shift.shiftstart = fix_timezone_app(@shift.shiftstart)
    @shift.shiftend = fix_timezone_app(@shift.shiftend)
    @shift.update_attribute(:ingcal, true)
    redirect_to shifts_path
  end

  def create_date
    p = params[:shift]
    t = params[:time]
    p_1 = p[:"shiftstart(1i)"].to_i
    p_2 = p[:"shiftstart(2i)"].to_i
    p_3 = p[:"shiftstart(3i)"].to_i
    dt = Date.new(p_1, p_2, p_3)
    h = t[:hour].to_i
    m = t[:min].to_i
    final_dt = dt + h.hour + m.minute
    return final_dt.to_datetime
  end

  def update
    @shift = Shift.find params[:id]
    date_update = create_date
    update_helper(date_update, @shift, params)
    gcal_event_update(0, @shift) if @shift.owner == '***'
    user = User.find_by_first_name(@shift.owner)
    gcal_event_update(user.id, @shift) if @shift.owner != '***'
    redirect_to shifts_path
  end

  def destroy
    @shift = Shift.find(params[:id])
    gcal_event_delete(@shift.event_id)
    @shift.destroy
    flash[:notice] = "Shift deleted."
    redirect_to shifts_path
  end
end
