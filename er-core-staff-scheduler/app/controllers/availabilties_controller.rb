class AvailabilitiesController < ApplicationController
	
	def index
		@availabilities = Availability.all
	end

end