require 'spec_helper'

describe PasswordResetsController do

  let(:user_params) do
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
	}
  end
  before do
	@user = User.create(user_params)
  end
  context "for checking update succeeds" do
    before do
   	  @user.password_reset_token = "gB5KGF-3hC4RNHCK5niz9A"
   	  @user.password_reset_sent_at = Time.zone.now
   	  @user.save!(validate: false) 
      put :update, id: @user.password_reset_token
  	end
 
  	it { should redirect_to(login_path) }
  end

  context "for checking update with expired reset token" do
    before do
      @user.password_reset_token = "gB5KGF-3hC4RNHCK5niz9A"
      @user.password_reset_sent_at = (Time.zone.now - 1.day).to_date
      @user.save!(validate: false) 
      put :update, id: @user.password_reset_token
    end

  	it {should redirect_to(new_password_reset_path)}
  end

  context "for checking edit succeeds" do
    before do
   	  @user.password_reset_token = "gB5KGF-3hC4RNHCK5niz9A"
   	  @user.password_reset_sent_at = Time.zone.now
   	  @user.save!(validate: false) 
      put :edit, id: @user.password_reset_token
  	end

  	it {@user.should_not be_nil}
  end

  context "for checking create fail" do
    before do
      put :create, id: nil
  	end

  	it {should redirect_to(new_password_reset_path)}
  end

  context "for checking create succeeds" do
    before do
      User.stub(:find_by_email) { @user }
      put :create, id: @user.email
  	end

  	it "checks create " do
  		should redirect_to(login_path)
  	end
  end
end
