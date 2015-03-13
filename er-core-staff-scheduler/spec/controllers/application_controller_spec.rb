require 'spec_helper'

describe ApplicationController do
describe "current_user" do
	let(:user_params) do
		{
			name: 'bob',
			usertype: 'Administrator',
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
      hash = {name: 'bob'}
      subject.should_receive(:session).and_return hash
      subject.current_user.should_not be_present
    end
  end

end
