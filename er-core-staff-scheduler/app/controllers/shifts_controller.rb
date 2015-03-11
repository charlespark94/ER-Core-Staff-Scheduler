class ShiftsController < ApplicationController
	
	def index
      if session[:user_id] == nil
        redirect_to login_path and return
      end
		@shifts = Shift.all
	end

	def show
		id = params[:id]
		@shift = Shift.find(id)
	end

end