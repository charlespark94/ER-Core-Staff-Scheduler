require 'spec_helper'

describe User do
  before { @user = User.new(first_name: "Example User First Name", last_name: "Example User Last Name", usertype: "Administrator", fte: "0.8", username: "admin", password: "admin", password_confirmation: "admin")}

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name)}
  it { should respond_to(:usertype) }
  it { should respond_to(:fte) }  
  it { should respond_to(:username) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  describe "when a name is not present" do
  	before do
      @user.first_name = ""
      @user.last_name = ""
    end
  	it { should_not be_valid }
  end

  describe "when a username is not present" do
  	before {@user.username = "" }
  	it { should_not be_valid }
  end

  describe "when username is already taken" do
  	before do
  	  user_with_same_username = @user.dup
  	  user_with_same_username.username = @user.username
  	  user_with_same_username.save
  	end
  	it {should_not be_valid}
  end

  describe "when password is not present" do
  	before do
  	  @user = User.new(first_name: "Example User First Name", last_name: "Example User Last Name", usertype: "Administrator", fte: "0.1", username: "admin", password: "admin", password_confirmation: "")
  	end
  	it { should_not be_valid}
  end

  describe "when password doesn't match confirmation" do
  	before {@user.password_confirmation = "mismatch"}
  end

  describe "when password confirmation is nil" do
  	before do
  	  @user = User.new(first_name: "Bob", last_name: "Smith", usertype: "Administrator", fte:"1.0", username: "bobid", password: "bobpass", password_confirmation: nil)
  	end
  	it {should be_valid}
  end
  
  describe "return value of authentication for invalid password" do
  	before {@user.save}
  	let(:found_user) {User.find_by_username(@user.username)}
  	describe "invlaid password" do
  	  let(:user_for_invalid_password) {found_user.match_password('invalid')}
  	  it { should_not eq user_for_invalid_password}
  	  specify {expect(user_for_invalid_password).to be_false}
  	end
  	describe "valid password" do
  	  it { should == User.authenticate(@user.username, @user.password)}
  	end
  end
end
