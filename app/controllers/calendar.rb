module Calendar
  require 'google/api_client'
  require 'active_support/concern'
  require 'yaml'
  extend ActiveSupport::Concern

  #@googleapi_hash = YAML.load_file("#{Rails.root}/config/.googleapi.yaml")
  attr_accessor :googleapi_hash
  @googleapi_hash = YAML.load_file(".googleapi.yaml")

  API_VERSION = 'v3'
  CACHED_API_FILE = "calendar-#{API_VERSION}.cache"
  CALENDAR_ID = @googleapi_hash["calendarId"]
  

  def gcal_event_insert
		params = {
			calendarId: CALENDAR_ID
		}
		result = client.execute(
			:api_method => calendar.events.insert,
			:parameters => params,
			:body_object => convert_to_gcal_event
		)
		logger.debug(result.data.to_yaml)
		result
	end

	def gcal_event_update
		params = {
			calendarId: CALENDAR_ID,
			eventId: self.gcal_id
		}
		result = client.execute(
			:api_method => calendar.events.update,
			:parameters => params,
			:body_object => convert_to_gcal_event
		)
		logger.debug(result.data.to_yaml)
	end

	def gcal_event_delete
		params = {
			calendarId: CALENDAR_ID,
			eventId: self.gcal_id
		}
		result = client.execute(
			:api_method => calendar.events.delete,
			:parameters => params
		)
		logger.debug(result.data.to_yaml)
	end

private
	def convert_to_gcal_event
		event = {
			'summary' => self.name,
			'description' => self.description,
			'start' => {
				'dateTime' => self.tstart
			},
			'end' => {
				'dateTime' => self.tend
			},
			'location' => get_event_location,
			'extendedProperties' => {
		'private' => {
			'id' => self.id
		}
			}
		}
	end

	def get_event_location
		[self.location.try(:name),
			self.location.try(:address),
			self.location.try(:city),
			self.location.try(:country)].compact.join(", ")
	end

	def init_client
		@googleapi_hash = YAML.load_file(".googleapi.yaml")	

		@client = Google::APIClient.new(:application_name => 'ER-Core-Staff-Scheduler', :application_version => '1.0.0')

		# Load our credentials for the service account
		#key = Google::APIClient::KeyUtils.load_from_pkcs12(Rails.application.secrets.key_file, Rails.application.secrets.key_secret)
		key = Google::APIClient::KeyUtils.load_from_pkcs12(@googleapi_hash["key_file"], @googleapi_hash["key_secret"])
		#key = Google::APIClient::KeyUtils.load_from_pkcs12(".keyfile.p12", "notasecret")
		@client.authorization = Signet::OAuth2::Client.new(
			#:client_id => @googleapi_hash["client_id"],
			#:client_secret => @googleapi_hash["client_secret"],
			:token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
			:audience => 'https://accounts.google.com/o/oauth2/token',
			:scope => 'https://www.googleapis.com/auth/calendar.readonly',
			:issuer => @googleapi_hash["service_account_email"],
			#:person => @googleapi_hash["impersonate_user_email"],
			:signing_key => key)

		# Request a token for our service account
		@client.authorization.fetch_access_token!
		return @client
	end

	def init_calendar
		@calendar = nil
		# Load cached discovered API, if it exists. This prevents retrieving the
		# discovery document on every run, saving a round-trip to the discovery service.
		if File.exists? CACHED_API_FILE
			File.open(CACHED_API_FILE) do |file|
		@calendar = Marshal.load(file)
			end
		else
			@calendar = @client.discovered_api('calendar', API_VERSION)
			File.open(CACHED_API_FILE, 'w') do |file|
		Marshal.dump(@calendar, file)
			end
		end
	end

  def get_calendar
  	@service = client.discovered_api('calendar', API_VERSION)
  	params = {
			calendarId: CALENDAR_ID
		}
  	result = client.execute(
  		:api_method => @service.calendars.get,
  		:parameters => params)
  	logger.debug(result.data.to_yaml)
  	return result.data.summary
  end

	def client
		@client ||= init_client
	end

	def calendar
		@calendar ||= init_calendar
	end

end