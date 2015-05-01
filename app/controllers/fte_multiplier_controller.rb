class FteMultiplierController < ApplicationController
	def index
		@users = User.all
		@users.each do |user|
			if (params[:"#{user.id}"] != nil)
				user.update_attribute(:fte_multiplier, params[:"#{user.id}"])
				user.update_attribute(:fte, params[:"#{user.id}_fte"])
			end
		end
	end
end
