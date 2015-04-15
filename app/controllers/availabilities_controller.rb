class AvailabilitiesController < ApplicationController

	
	def index
		if session[:user_id] == nil
			redirect_to login_path
		end
		@availabilities = Availability.all
		@shifts = Shift.all
		# @shifts.each do |shift|
		# 	shift.update_attributes(:users => nil)
		# 	shift.update_attributes(:possible_users => nil)
		# end

		update_availability(@shifts)
	end

	def update_availability(shifts)
		shifts.each do |shift|
			if users_exist?(shift.users)
				in_user = shift.users.split(" ").include?(session[:user_id])
			end
			if users_exist?(shift.possible_users)
				in_pos = shift.possible_users.split(" ").include?(session[:user_id].to_s)
			end 
				#not_choose = (not in_pos) and (not in_user)
			if (in_user || in_pos)
				not_choose = false
			else
				not_choose = true
			end
			if params[:"#{shift.id}"] == "yes"
				
				if not_choose
					newstring = "#{shift.users} #{session[:user_id]}"
					shift.update_attributes(:users => newstring)
				end
				#shift.update_attributes(:possible_users => nil)
			elsif params[:"#{shift.id}"] == "maybe"
				if not_choose
					newstring = "#{shift.possible_users} #{session[:user_id]}"
					shift.update_attributes(:possible_users => newstring)
				end
				#shift.update_attributes(:users => nil)
			elsif params[:"#{shift.id}"] == "no"
				#shift.update_attributes(:possible_users => nil)
				#shift.update_attributes(:users => nil)
			end
		end
	end

	def users_exist?(val)
		return !val.nil?
	end

end