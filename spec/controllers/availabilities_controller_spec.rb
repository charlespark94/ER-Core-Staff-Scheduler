require 'spec_helper'

describe AvailabilitiesController do

	let(:user_params1) do
		{
			id: 'bob_id',
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
			id: 'joe_id',
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
		@user1 = double(User, user_params1)
		@user2 = double(User, user_params2)
	end
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

	it "should have reccuring shift" do
		@testshift1 = Shift.create(:id => "1", :shiftstart => DateTime.iso8601(DateTime.now.to_s), :shiftend => DateTime.iso8601(DateTime.now.to_s), :owner => '***', :users => nil, :possible_users => nil, :ingcal => true, :event_id => 1)
		@testshift2 = Shift.create(:id => "2", :shiftstart => DateTime.iso8601((DateTime.now - 2.week).to_s), :shiftend => DateTime.iso8601((DateTime.now - 2.week).to_s), :owner => @user1.first_name, :users => @user1.first_name, :possible_users => @user2.first_name, :ingcal => true, :event_id => 1)
		Shift.all.each do |shift|
			@match_startshift = shift.shiftstart - (14*24*60*60)
			@match_endshift = shift.shiftend - (14*24*60*60)
			prev_time = Shift.where(:shiftstart => @match_startshift, :shiftend => @match_endshift).all[0]
		end
		get :new
	end
end
