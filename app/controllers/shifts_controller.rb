class ShiftsController < ActionController::Base
  include Calendar
  def index
    @shifts = Shift.all
    #@shifts.each do |shift|
    #  if shift.ingcal == true
    #    next
    #  else
    #    dt_start = shift.shiftstart
    #    dt_end = shift.shiftend
    #    dt_doc = shift.owner
    #    gcal_event_insert(0, dt_doc, "core", dt_start, dt_end)
    #    shift.ingcal = true
    #    shift.save!
    #  end
    #end
  end

  def new
    #@shift = Shift.new
  end

  def show
    @shift = Shift.find params[:id]
  end

  def edit
    @shift = Shift.find params[:id]
  end

  def create
    @shift = Shift.create!(params[:shift])
    flash[:notice] = "Shift was successfully created."
    dt_start = @shift.shiftstart
    dt_end = @shift.shiftend
    dt_doc = @shift.owner
    gcal_event_insert(0, dt_doc, "core", dt_start, dt_end)
    @shift.ingcal = true
    @shift.save!
    redirect_to shifts_path
  end
  
  def update
    @shift = Shift.find params[:id]
    #@uservalue = @shift.users.split(" ")
    @shift.update_attributes!(params[:shift])
    dt_start = @shift.shiftstart
    dt_end = @shift.shiftend
    dt_doc = @shift.owner  
    if (@shift.users != " " || @shift.possible_users != " ") &&(dt_doc != nil)
      gcal_event_insert(User.find_by_first_name(dt_doc).id, dt_doc, "core", dt_start, dt_end )
      gcal_event_delete(0, dt_start)
    else
      gcal_event_update(0, dt_doc, "core", dt_start, dt_end)
    end

    #if dt_doc == "***" || dt_doc == nil
    #  gcal_event_update(0, dt_doc, "core", dt_start, dt_end)
    #else   
    #  gcal_event_insert(User.find_by_first_name(dt_doc).id, dt_doc, "core", dt_start, dt_end )
    #  gcal_event_delete(0, dt_start)
    #end
    flash[:notice] = "Shift was successfully updated."
    redirect_to shift_path(@shift)
  end

  def destroy
    @shift = Shift.find(params[:id])
    dt_start = @shift.shiftstart
    dt_doc = @shift.owner
    if dt_doc == '***' || dt_doc == "" || dt_doc.nil? || dt_doc == " "
      gcal_event_delete(0, dt_start)
    else
      gcal_event_delete(User.find_by_first_name(dt_doc).id, dt_start)
    end
    @shift.destroy
    flash[:notice] = "Shift deleted."
    redirect_to shifts_path
  end
end
