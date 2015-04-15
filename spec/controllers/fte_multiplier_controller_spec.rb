require 'spec_helper'

describe FteMultiplierController do
	let(:user_params) do
			{
				id: '1',
				first_name: 'second',
				last_name: 'smith',
				usertype: 'Administrator',
				email: 'vacorescheduling@gmail.com',
				fte: '0.8',
				username: 'admin',
				password: 'admin',
				password_confirmation: 'admin',
				verified: 'true',
			}
	end
	
	it "should update fte mutiplier" do
		@user = User.create(user_params)
		controller.stub(:params).and_return({:"1" => 1})
		get :index, user_params, {user_id: 1}
	end
		
end
