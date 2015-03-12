class AvailabilitiesController < ApplicationController
	
	def index
		@availabilities = Availability.all
		@shifts = Shift.all
		if params[:action]

			# @shifts.each do |shift|
			# 	if params.has_key?(1.to_s.to_sym)
			# 		shift.update_attributes(:users => 2)
			# 	end
			# end

			@shifts.each do |shift|
				shift.update_attributes(:users => shift.id)
			end

			# @shifts.each do |shift|
			# 	if params[shift.id.to_s] == 'yes'
			# 		shift.update_attributes(:users => 13) # this will be user.id down the line
			# 	elsif params[shift.id.to_s] == 'maybe'
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