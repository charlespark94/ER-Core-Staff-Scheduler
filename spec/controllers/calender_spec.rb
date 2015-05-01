require 'spec_helper'
require 'google/api_client'

module Calendar
	describe Calendar do
		include Calendar
		before do
			double(:gcal_id)
			Calendar.stub(:gcal_event_insert)
			Calendar.stub(:gcal_event_update)
			Calendar.stub(:gcal_event_delete)
			Calendar.stub(:convert_to_gcal_event)
		end
		it "checks gcal_event_insert" do
			gcal_event_update('1', Shift.new)
			gcal_event_update('1', Shift.new)
			convert_to_gcal_event('1', 'bob', 'Administrator', '1','1', '1')
			gcal_event_delete('1')
			File.stub(:exists?).and_return(false)
			init_calendar
		end
	end

end
