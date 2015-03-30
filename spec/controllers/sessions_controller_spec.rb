require 'spec_helper'

describe SessionsController do
	render_views
	describe "new" do
		it "should redirect home" do
			get :new, nil, {user_id: 1}
			response.should redirect_to(home_path)
		end
	end
	describe "create" do
		context "with admin user" do
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
			before(:each) do
				@user = User.create(user_params)
			end

			it 'should redirect home' do
				@user.should be_present
				@user.id.should be_present
			end

			it 'should redirect to home' do
				post :create, user_params
				response.should redirect_to(home_path)
			end

			it 'should not allow login without username' do
				post :create, user_params.slice(:username)
				response.should redirect_to(login_path)
			end

			it 'should not allow login without password' do
				post :create, user_params.slice(:password)
				response.should redirect_to(login_path)
			end			

		end

		context 'without registration' do
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

			it 'should create new user' do
				post :create, user_params
				created_user = User.new(user_params)
				created_user.should be_present
			end

			it 'should redirect to login' do
				post :create, user_params
				response.should redirect_to(login_path)
			end
		end

		describe 'destroy' do
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

			before do
				@current_user = User.create!(user_params)
				controller.stub(:match_password)
				controller.stub(:current_user) {@current_user}
			end

			it "should delete current user" do
				post :destroy, id: @current_user.id
				response.should redirect_to(login_path)
			end
		end
	end
end
