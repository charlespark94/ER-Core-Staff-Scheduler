class VerificationController < ApplicationController
	#skip_before_filter :check_account_verified

	def not
		user = User.find_by_id(session[:user_id])
		if user.verified == true
			redirect_to home_path
		end
	end

	def index
		user = User.find_by_id(params[:format])
		user.verifier
		UserMailer.been_verified(user).deliver
	end
end
