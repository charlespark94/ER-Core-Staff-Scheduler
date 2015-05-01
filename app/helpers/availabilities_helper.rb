module AvailabilitiesHelper
	def recurring_avail(start, ending)
		return shifts = Shift.where("shiftstart >= ?", start.to_datetime).where("shiftstart < ?", ending.to_datetime)
	end

	def recur_helper(shift)
		prev_shift = Shift.where("shiftstart = ?", shift.shiftstart - 2.weeks).where("shiftend = ?", shift.shiftend - 2.weeks)
		raise "#{prev_shift}            #{prev_shift[0]}".inspect
		return if prev_shift.nil?
		availability = Availability.where(user_id: session[:user_id], shift_id: shift.id).first
		prev_avail = Availability.where(user_id: session[:user_id], shift_id: prev_shift[0].id).first
		availability.update_attribute(:availability, prev_avail.availability)
	end
end
