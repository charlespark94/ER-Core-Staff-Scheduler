require 'spec_helper'

describe ApplicationController do
describe "current_user" do
	let(:user_params) do
		{
			first_name: 'bob',
			last_name: 'smith',
			usertype: 'Administrator',
			email: 'vacorescheduling@gmail.com',
			fte: '0.8',
			username: 'admin',
			password: 'admin',
			password_confirmation: 'admin'
		}
	end
    it "should return nil if no one is logged in" do
      subject.current_user.should be_nil
    end
    it "should return currently logged in user" do
      @current_user = User.create(user_params)
      hash = {first_name: 'bob'}
      subject.should_receive(:cookies).and_return hash
      subject.current_user.should_not be_present
    end
  end

end
