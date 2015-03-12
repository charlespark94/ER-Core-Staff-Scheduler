class AvailabilitiesController < ApplicationController
	
	def index
		@availabilities = Availability.all
		@shifts = Shift.all

		# @shifts.each do |shift|
		# 	shift.update_attributes(:users => nil)
		# 	shift.update_attributes(:possible_users => nil)
		# end

		@shifts.each do |shift|
			if params[:"#{shift.id}"] == "yes"
				shift.update_attributes(:users => 1)
			elsif params[:"#{shift.id}"] == "maybe"
				shift.update_attributes(:possible_users => 1)
			end
		end
	end

end