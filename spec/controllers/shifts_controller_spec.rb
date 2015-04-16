require 'spec_helper'

describe ShiftsController do


  describe 'editing a shift' do
    it 'should rendering index' do
      get :index, {:id => 1}
      response.should render_template('index')
    end

    it 'should edit a shift' do     
      @testshift = double(Shift, :shiftstart => DateTime.iso8601('2015-05-01T10:00:00'), :shiftend => DateTime.iso8601('2015-05-01T18:00:00'), :id => '1')
      Shift.stub(:find).with('1').and_return(@testshift)
      @testshift.stub(:update_attributes!).and_return(true)
      put :update, {:id => '1', :shiftend => DateTime.iso8601('2015-05-01T22:00:00')}
      #response.should redirect_to(shifts_path)
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
      ShiftsController.stub(:create).and_return(double('Shift'))
      post 'create', {:id => '2'}
    end


    it 'should delete the shift' do
      @testshift = double(Shift, :shiftstart => DateTime.iso8601('2015-05-01T12:00:00'), :shiftend => DateTime.iso8601('2015-05-01T16:00:00'), :id => '3')
      Shift.stub(:find).with('3').and_return(@testshift)
      @testshift.should_receive(:destroy)
      delete 'destroy', {:id => '3'}
      response.should redirect_to(shifts_path)
    end
  end

  describe 'add a doctor to shift' do
   before :each do
      @testshift20 = double(Shift, :shiftstart => DateTime.iso8601('2015-05-01T07:00:00'), :shiftend => DateTime.iso8601('2015-05-01T19:00:00'), :id => '20', :possible_users => 'Smith Evans Applegate')
      Shift.stub(:find).with('20').and_return(@testshift10)
   end

   it 'should add a doctor to an existing shift' do
     Shift.stub(:find).with('20').and_return(@testshift20)
     @testshift20.stub(:update_attributes!).and_return(true)
     put :update, {:owner => 'Smith'}
     Calendar.stub(gcal_event_update('1', 'Smith', 'core', @testshift20.shiftstart, @testshift20.shiftend)
   end
  end
end
