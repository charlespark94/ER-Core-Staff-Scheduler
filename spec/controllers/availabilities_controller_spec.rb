require 'spec_helper'

describe AvailabilitiesController do
	it 'should rendering index' do
		get :index, {:id => 1}
		response.should_not render_template('index')
	end

	before(:each) do
		@shift = Shift.create!(:id => 1, :shiftstart => '2015-03-08 07:00:00 UTC', :shiftend => '2015-03-08 19:00:00 UTC')			
	end		

	it "should update attribute when yes" do
		get :index, {:"1" => 'yes'}
		expect(@shift.update_attributes(:possible_users => nil, :users => 1)) 
	end

	it "should update attribute when maybe" do
		get :index, {:"1" => 'maybe'}
		expect(@shift.update_attributes(:possible_users => 1, :users => nil)) 
	end

	it "should update attribute when no" do
		get :index, {:"1" => 'no'}
		expect(@shift.update_attributes(:possible_users => nil, :users => nil)) 
	end
end
