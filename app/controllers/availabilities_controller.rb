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

	def new
		@shifts = Shift.all
		@days_of_week = []

		#getting the dates of the current payperiod
		today = Date.today
		(today.at_beginning_of_week..today.at_end_of_week).map.each {|day| @days_of_week << day}
		next_week = Date.today + 7
		(next_week.at_beginning_of_week..next_week.at_end_of_week).map.each {|day| @days_of_week << day}
		@first_shift = @days_of_week[2].to_s[5..6]

		#getting the shifts of the current pay period
		@current_shifts = []

		@shifts.each do |shift|
			@days_of_week.each do |day|
				if shift.shiftstart.to_s[0..9] == day.to_s[0..9]
					@current_shifts << shift
				end
			end
		end

		#mapping each current shift to the shift from two weeks before
		@current_shifts.each do |shift|
			@match_startshift = shift.shiftstart - (14*24*60*60)
			@match_endshift = shift.shiftend - (14*24*60*60)
			prev_shifts = Shift.where(:shiftstart => @match_startshift, :shiftend => @match_endshift).all
			prev_time = prev_shifts[0]

			#setting each preference of current shift to preference of previous shift
			if prev_time == nil
				redirect_to availabilities_path
			else
				if users_exist?(prev_time.users)
					in_user = prev_time.users.split(" ").include?(session[:user_id].to_s)
				end
				if users_exist?(prev_time.possible_users)
					in_pos = prev_time.possible_users.split(" ").include?(session[:user_id].to_s)
				end

				if in_user
					recurring_helper(shift, :users)
				end

				if in_pos
					recurring_helper(shift, :possible_users)
				end
			end
		end
	end

	def recurring_helper(shift, val)
		newstring = "#{shift.users} #{session[:user_id]}"
		shift.update_attribute(val, newstring)
	end

end