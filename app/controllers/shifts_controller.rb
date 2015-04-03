class ShiftsController < ActionController::Base
  include Calendar
  def index
    @shifts = Shift.all
    @shifts.each do |shift|
      if shift.ingcal == true
        next
      else
        dt_start = shift.shiftstart
        dt_end = shift.shiftend
        dt_doc = shift.owner
        gcal_event_insert(0, dt_doc, "core", dt_start, dt_end)
        shift.ingcal = true
        shift.save!
      end
    end
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
    redirect_to shifts_path
  end
  
  def update
    @shift = Shift.find params[:id]
    @shift.update_attributes!(params[:shift])
    flash[:notice] = "Shift was successfully updated."
    redirect_to shift_path(@shift)
  end

  def destroy
    @shift = Shift.find(params[:id])
    @shift.destroy
    flash[:notice] = "Shift deleted."
    redirect_to shifts_path
  end
end
