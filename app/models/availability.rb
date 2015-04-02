class Availability < ActiveRecord::Base
	extend SimpleCalendar
	has_calendar
  attr_accessible :id, :preferred, :maybe
end
