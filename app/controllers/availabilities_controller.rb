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
	end

	def new
		if session[:user_id] == nil
			redirect_to login_path
		end
		@availabilities = Availability.all
		@shifts = Shift.all
		update_availability(@shifts)
		redirect_to availabilities_path
	end

	def update_availability(shifts)
		shifts.each do |shift|
			if !params[:"#{shift.id}"].nil?
				@availability = Availability.where(user_id: session[:user_id], shift_id: shift.id).first
				if @availability.nil?
					@availability = shift.availabilities.build(:user_id => session[:user_id])
				end
				if params[:"#{shift.id}"] == "yes"
					@availability.update_attributes(:availability => 2)
				elsif params[:"#{shift.id}"] == "maybe"
					@availability.update_attributes(:availability => 1)
				elsif params[:"#{shift.id}"] == "no"
					@availability.update_attributes(:availability => 0)
				end
				if !@availability.save
					flash[:notice] = "Something bad happened, saving new ability in availabilities_controller"
				end
			end

			# if users_exist?(shift.users)
			# 	in_user = shift.users.split(" ").include?(session[:user_id])
			# end
			# if users_exist?(shift.possible_users)
			# 	in_pos = shift.possible_users.split(" ").include?(session[:user_id].to_s)
			# end 
			# 	#not_choose = (not in_pos) and (not in_user)
			# if (in_user || in_pos)
			# 	not_choose = false
			# else
			# 	not_choose = true
			# end
			# if params[:"#{shift.id}"] == "yes"
				
			# 	if not_choose
			# 		newstring = "#{shift.users} #{session[:user_id]}"
			# 		shift.update_attributes(:users => newstring)
			# 	end
			# 	#shift.update_attributes(:possible_users => nil)
			# elsif params[:"#{shift.id}"] == "maybe"
			# 	if not_choose
			# 		newstring = "#{shift.possible_users} #{session[:user_id]}"
			# 		shift.update_attributes(:possible_users => newstring)
			# 	end
			# 	#shift.update_attributes(:users => nil)
			# elsif params[:"#{shift.id}"] == "no"
			# 	#shift.update_attributes(:possible_users => nil)
			# 	#shift.update_attributes(:users => nil)
			# end
		end
	end

	def users_exist?(val)
		return !val.nil?
	end

end