class ShiftsController < ApplicationController
	
	def index
		@shifts = Shift.all
	end

	def show
		id = params[:id]
		@shift = Shift.find(id)
	end

end