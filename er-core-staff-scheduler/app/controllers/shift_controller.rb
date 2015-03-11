class ShiftController < ActionController::Base
  def create
    @shift = Shift.create!(params[:shift])
    flash[:notice] = "#{@shift.id} was created"
    redirect_to shifts_path
  end

  def edit
    @shift = Shift.find(params[:id])
  end

  def update
   @shift = Shift.find(params[:id])
   @shift.update_attributes!(params[:shift])
   flash[:notice] = "#{@shift.id} was updated"
   redirect_to shifts_path 
  end

  def destroy
   @shift = Shift.find(params[:id])
   @shift.destroy
   flash[:notice] = "#{@shift.id} was destroyed"
   redirect_to shifts_path 
  end
end
