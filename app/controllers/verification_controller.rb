class VerificationController < ApplicationController
	skip_before_filter :check_account_verified
	skip_before_filter :check_logged_in

	def not
		if session[:user_id] == nil
			redirect_to login_path
		else
			user = User.find_by_id(session[:user_id])
			if user.verified == true
				redirect_to home_path
			end
		end
	end

	def index
		user = User.find_by_id(params[:format])
		verification(user)
	end

	def verification(user)
		if user != nil
			user.user_verification
			UserMailer.been_verified(user).deliver
		end
	end
end
