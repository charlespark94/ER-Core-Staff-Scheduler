class ShiftsController < ActionController::Base
  def index
    @shifts = Shift.all
  end

  def new
    #@shift = Shift.new
  end


  def create
    @shift = Shift.create!(params[:shift])
    flash[:notice] = "Shift was successfully created."
    redirect_to shifts_path
  end

  def edit
    @shift = Shift.find params[:id]
  end

  def update
    @shift = Shift.find params[:id]
    @shift.update_attributes!(params[:shift])
    flash[:notice] = "Shift was successfully updated."
    redirect_to shifts_path()
  end

  def destroy
    @shift = Shift.find(params[:id])
    @shift.destroy
    flash[:notice] = "Shift deleted."
    redirect_to shifts_path
  end
end
