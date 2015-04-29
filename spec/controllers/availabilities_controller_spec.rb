require 'spec_helper'

describe AvailabilitiesController do
	include Calendar
	let(:user_params1) do
		{
			id: '1',
			first_name: 'bob',
			last_name: 'smith',
			usertype: 'Administrator',
			email: 'vacorescheduling@gmail.com',
			fte: '0.8',
			username: 'admin',
			password: 'admin',
			password_confirmation: 'admin',
			verified: 'true'
		}
	end

	let(:user_params2) do
		{
			id: '2',
			first_name: 'joe',
			last_name: 'smith',
			usertype: 'Administrator',
			email: 'vacorescheduling@gmail.com',
			fte: '0.8',
			username: 'admin',
			password: 'admin',
			password_confirmation: 'admin',
			verified: 'true'
		}
	end

	before(:each) do
		@flags = Flag.create(:flagstart => DateTime.strptime("04/19/2015 00:00", "%m/%d/%Y %H:%M"), :recurring => false)
		Flag.stub(:find).and_return(@flags)
		Calendar.stub(:gcal_event_insert)
		Calendar.stub(:gcal_event_update)
		Calendar.stub(:gcal_event_delete)
		@user1 = User.create(user_params1)
		@user2 = User.create(user_params2)
		controller.stub(:session).and_return({:user_id => 1})

	end

	it 'should update all' do
		get :update_all
		response.should redirect_to(availabilities_path)
	end

	it 'should rendering index' do
		controller.stub(:session).and_return({:user_id => nil})
		get :index, {:id => 1}
		response.should_not render_template('index')
	end

	before(:each) do
		@shift = Shift.create!(:id => 1, :shiftstart => '2015-03-08 07:00:00 UTC', :shiftend => '2015-03-08 19:00:00 UTC')
		@availability = Availability.where(user_id: 1, shift_id: 1).first
		controller.stub(:params).and_return({:"#{@shift.id}" => 1})			
	end		

	it "should update attribute when yes" do
		get :index, {:"1" => 'yes'}
		#expect(@availability.update_attributes(:availability => 2)) 
	end

	it "should update attribute when maybe" do
		get :index, {:"1" => 'maybe'}
		#expect(@availability.update_attributes(:availability => 1)) 
	end

	it "should update attribute when no" do
		get :index, {:"1" => 'no'}
		#expect(@availability.update_attributes(:availability => 0)) 
	end

	it "should update attribute should return flash" do
		Availability.stub(:save).and_return(false)
		controller.stub(:flash).with(:notice).and_return("Something bad happened, saving new ability in availabilities_controller")
		get :index, {}
	end

	it "should have reccuring shift" do
		@testshift1 = Shift.create(:id => "1", :shiftstart => DateTime.iso8601(DateTime.now.to_s), :shiftend => DateTime.iso8601(DateTime.now.to_s), :owner => '***', :users => [], :possible_users => [], :ingcal => true, :event_id => 1)
		@testshift2 = Shift.create(:id => "2", :shiftstart => DateTime.iso8601((DateTime.now - 2.week).to_s), :shiftend => DateTime.iso8601((DateTime.now - 2.week).to_s), :owner => @user1.last_name, :users => [], :possible_users => [], :ingcal => true, :event_id => 1)
		Shift.all.each do |shift|
			@match_startshift = shift.shiftstart - (14*24*60*60)
			@match_endshift = shift.shiftend - (14*24*60*60)
			prev_shifts = Shift.where(:shiftstart => @match_startshift, :shiftend => @match_endshift).all
			prev_time = prev_shifts[0]
		end
		get :new
	end
end
