require 'spec_helper'

describe UsersController do
	render_views

	describe 'create' do
		context 'with invalid parameters' do
			let(:user_params) do
				{
					name: 'Charles Park',
					usertype: 'Administrator',
					fte: "0.8",
					username: 'admin',
					password: 'admin',
					password_confirmation: 'not_admin'
				}
			end

			it 'should render new' do
				post :create, :user => user_params
				response.should render_template("new")
			end

			it 'should render new without password' do
				post :create, user: user_params.slice(:password)
				response.should render_template("new")
			end

			it 'should render new without email' do
				post :create, user: {username: ''}
				response.should render_template("new")
			end
		end

		context 'with valid parameters' do
			let(:user_params) do
				{
					name: 'Charles Park',
					usertype: 'Administrator',
					fte: "0.8",
					username: 'admin',
					password: 'admin',
					password_confirmation: 'admin'
				}
			end
			it 'should create new user' do
				post :create, :user => user_params
				created_user = User.find_by_username(user_params[:username])
				created_user.should be_present
			end

			it 'should redirect to login' do
				post :create, :user => user_params
				response.should redirect_to(login_path)
			end
		end
	end
end
