class FteMultiplierController < ApplicationController
	def index
		@users = User.all
		@users.each do |user|
			#user.fte_multiplier = params[:"#{user.id}"]
			if (params[:"#{user.id}"] != nil)
				user.multiplier(params[:"#{user.id}"])
			end
		end
	end
end
