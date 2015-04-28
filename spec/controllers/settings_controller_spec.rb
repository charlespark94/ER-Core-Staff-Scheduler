require 'spec_helper'

describe SettingsController do
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

	before(:each) do
		@user = User.create(user_params1)
		controller.stub(:session).and_return({:user_id => 1})
	end

	it "should go to index" do
		get :index, {:id => 1}
		response.should render_template('index')
	end

	#it "should redirect to edit page" do
	#	User.stub(:find_by_id).and_return(@user)
	#	put :update, {:id => "1", :password => "test", :password_confirmation => "not"}
	#	response.should redirect_to(edit_setting_path(@user))
	#end
end
