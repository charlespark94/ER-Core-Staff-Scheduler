module AvailabilitiesHelper
	def recurring_avail(start, ending)
		return shifts = Shift.where("shiftstart >= ?", start.to_datetime).where("shiftstart < ?", ending.to_datetime)
	end
end
