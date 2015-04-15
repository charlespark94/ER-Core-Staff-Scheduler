require 'spec_helper'

describe ShiftsController do


  describe 'editing a shift' do
    it 'should rendering index' do
      get :index, {:id => 1}
      response.should render_template('index')
    end

    it 'should redirect to edit page' do     
      @testshift = double(Shift, :id => "1", :shiftstart => DateTime.iso8601('2015-05-01T10:00:00'), :shiftend => DateTime.iso8601('2015-05-01T18:00:00'), :owner => '***', :users => nil, :possible_users => nil)
      Shift.stub(:find).with("1").and_return(@testshift)
      @testshift.stub(:update_attributes!).and_return(true)
      put :update, {:id => "1", :shiftend => DateTime.iso8601('2015-05-01T22:00:00')}
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
end
