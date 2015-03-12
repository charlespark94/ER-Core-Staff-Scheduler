class AvailabilitiesController < ApplicationController
	
	def index
		@availabilities = Availability.all
		@shifts = Shift.all
		if params[:action]
			@shifts.each do |shift|
				shift.update_attributes(:users => params[:1])
			end
			# @shifts.each do |shift|
			# 	if params[:shift_id] == 'yes'
			# 		shift.update_attributes(:users => 13) # this will be user.id down the line
			# 	elsif params[shift.id] == 'maybe'
			# 		shift.update_attributes(:possible_users => 2)
			# 	end
			# end

			# params.each do |k, v|
			# 	if v == 'yes'
			# 		@shift = Shift.find(1)
			# 		@shift.update_attributes(:users => 2)
			# 	elsif v == 'maybe'
			# 		@shift = Shift.find(2)
			# 		@shift.update_attributes(:possible_users => 2)
			# 	end
			# end
		end
	end

end