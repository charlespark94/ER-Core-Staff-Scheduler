class AvailabilitiesController < ApplicationController
	
	def index
		if session[:user_id] == nil
			redirect_to login_path
		end
		@availabilities = Availability.all
		@shifts = Shift.all
		@user = User.find_by_id(session[:user_id])

		# @shifts.each do |shift|
		# 	shift.update_attributes(:users => nil)
		# 	shift.update_attributes(:possible_users => nil)
		# end

		@shifts.each do |shift|
			if params[:"#{shift.id}"] == "yes"
				shift.update_attributes(:users => 1)
				shift.update_attributes(:possible_users => nil)
			elsif params[:"#{shift.id}"] == "maybe"
				shift.update_attributes(:possible_users => 1)
				shift.update_attributes(:users => nil)

				shift.update_attributes(:owner => "#{@user.first_name} #{@user.last_name}")
			elsif params[:"#{shift.id}"] == "no"
				shift.update_attributes(:possible_users => nil)
				shift.update_attributes(:users => nil)
			end
		end
	end

end