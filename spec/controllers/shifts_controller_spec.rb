require 'spec_helper'

describe ShiftsController do
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
  before(:each) do
    include Calendar
    controller.stub(:gcal_event_insert).and_return(true)
    @flags = Flag.create(:flagstart => DateTime.strptime("03/08/2015 00:00", "%m/%d/%Y %H:%M"), :recurring => true)
    Flag.stub(:find).and_return(@flags)
    @user = User.create(user_params1)
    controller.stub(:session).and_return({:user_id => 1})
    @tester = Shift.create(:shiftstart => DateTime.iso8601('2015-05-01T10:00:00'), :shiftend => DateTime.iso8601('2015-05-01T18:00:00'), :owner => '***', :users => [], :possible_users => " ")
  end


  describe 'editing a shift' do
    it 'should rendering index' do
      get :index, {:id => 1}
      response.should render_template('index')
    end

    it 'should update event' do
      @user = User.create(user_params1)
      @testshift = double(Shift, :id => "1", :shiftstart => DateTime.iso8601('2015-05-01T10:00:00'), :shiftend => DateTime.iso8601('2015-05-01T18:00:00'), :owner => '***', :users => nil, :possible_users => nil)
      Shift.stub(:find).with("1").and_return(@testshift)
      @testshift.stub(:update_attributes!).and_return(true)
      put :update, {:id => "1", :shiftend => DateTime.iso8601('2015-05-01T22:00:00')}
    end

  end 

  describe 'display shift info' do
    it 'should load show page' do
      @testshift = Shift.create(:id => "1", :shiftstart => DateTime.iso8601('2015-05-01T10:00:00'), :shiftend => DateTime.iso8601('2015-05-01T18:00:00'), :owner => '***', :users => [], :possible_users => [])
      Shift.stub(:find).with("1").and_return(@testshift)
      controller.stub(:params).and_return({:id => "1"})
      get :show, {:id => "1"}
    end
  end

  describe 'display edit info' do
    it 'should load show page' do
      @testshift = double(Shift, :id => "1", :shiftstart => DateTime.iso8601('2015-05-01T10:00:00'), :shiftend => DateTime.iso8601('2015-05-01T18:00:00'), :owner => '***', :users => nil, :possible_users => nil)
      Shift.stub(:find).with("1").and_return(@testshift)
      controller.stub(:params).and_return({:id => "1"})
      get :edit, {:id => "1"}
    end
  end


  describe 'create and delete shift' do
    before :each do
      @testshift10 = double(Shift, :shiftstart => DateTime.iso8601('2015-05-01T12:00:00'), :shiftend => DateTime.iso8601('2015-05-01T18:00:00'), :id => '10')
      Shift.stub(:find).with('10').and_return(@testshift10)

      @testshift11 = double(Shift, :shiftstart => DateTime.iso8601('2015-05-02T12:00:00'), :shiftend => DateTime.iso8601('2015-05-02T18:00:00'), :id => '11')
      Shift.stub(:find).with('11').and_return(@testshift11)

    end
     
    it 'should create a shift with attributes' do
      include Calendar
      controller.stub(:params).and_return({:"shift"=>{:"date(1i)"=>"2015", :"date(2i)"=>"4", :"date(3i)"=>"28", :"hour"=>"20", :"min"=>"00"}, :"length"=>{:"length"=>"1"}})
      controller.should_receive(:gcal_event_insert).and_return(true)
      post 'create', {}
    end


    it 'should delete the shift' do
      @testshift = double(Shift, :shiftstart => DateTime.iso8601('2015-05-01T12:00:00'), :shiftend => DateTime.iso8601('2015-05-01T16:00:00'), :id => '3', :owner => '***', :event_id => 1)
      Shift.stub(:find).with('3').and_return(@testshift)
      @testshift.should_receive(:destroy)
      delete 'destroy', {:id => '3'}
      response.should redirect_to(shifts_path)
    end
  end

  describe 'hours per person' do
    it 'should return a hash of assigned and required hours per person' do
      @testshift = Shift.create(:id => "1", :shiftstart => DateTime.iso8601('2015-05-01T10:00:00'), :shiftend => DateTime.iso8601('2015-05-01T18:00:00'), :owner => @user.first_name, :users => [], :possible_users => [], :ingcal => true, :event_id => 1)
      Shift.stub(:all).and_return([@testshift])
      controller.show_hours_per_person().should == {"***" => [0,0], @user.first_name => [8,64]}
    end
  end
end
