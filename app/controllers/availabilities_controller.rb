class AvailabilitiesController < ApplicationController
	include AvailabilitiesHelper
	def index
		@availabilities = Availability.all
		@shifts = Shift.order(:shiftstart)
		@flag = Flag.find_by_id(1)
		Time.zone = "UTC"
		@date_start = @flag.flagstart.to_date
		if !params[:newstart].nil?
			@date_start = params[:newstart].to_date
		end
		@next_seven = @date_start..(@date_start + 6)
		@second_seven = (@date_start + 7)..(@date_start + 13)
	end

	def update_all
		@availabilities = Availability.all
		@shifts = Shift.all
		update_availability(@shifts)
		redirect_to availabilities_path
	end

	def update_availability(shifts)
		shifts.each do |shift|
			if params[:"#{shift.id}"].nil?
				next
			end
			@availability = Availability.where(user_id: session[:user_id], shift_id: shift.id).first
			if @availability.nil?
				@availability = shift.availabilities.build(:user_id => session[:user_id])
			end
			update_availability_helper(@availability, params[:"#{shift.id}"])
			if !@availability.save
				flash[:notice] = "Something bad happened, saving new ability in availabilities_controller"
			end
		end
	end

	def update_availability_helper(availability, val)
		if val == "yes"
			availability.update_attributes(:availability => 2)
		elsif val == "maybe"
			availability.update_attributes(:availability => 1)
		elsif val == "no"
			availability.update_attributes(:availability => 0)
		end
	end

	def new
		@flag = Flag.find_by_id(1)
		@shifts = recurring_avail(@flag.flagstart, @flag.flagstart + 2.weeks)
		@shifts.each do |shift|
			prev_shift = Shift.where("shiftstart = ?", shift.shiftstart - 2.weeks).where("shiftend = ?", shift.shiftend - 2.weeks)
			next if prev_shift.nil?
			availability = Availability.where(user_id: session[:user_id], shift_id: shift.id).first
			prev_avail = Availability.where(user_id: session[:user_id], shift_id: prev_shift[0].id).first
			availability.update_attribute(:availability, prev_avail.availability)
		end
		redirect_to availabilities_path
	end

end
