require 'spec_helper'
require 'google/api_client'

module Calendar
	describe Calendar do
		include Calendar
		before do
			double(:gcal_id)
		end
		it "checks gcal_event_insert" do
			gcal_event_insert('1','bob','Administrator','1','1', '1')
			gcal_event_update('1', 'bob','Administrator', '1','1', '1')
			convert_to_gcal_event('1', 'bob', 'Administrator', '1','1', '1')
			gcal_event_delete('1')
		end
	end

end
