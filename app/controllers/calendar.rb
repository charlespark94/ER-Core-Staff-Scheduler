module Calendar
  require 'google/api_client'
  require 'active_support/concern'
  require 'yaml'
  extend ActiveSupport::Concern

  #@googleapi_hash = YAML.load_file("#{Rails.root}/config/.googleapi.yaml")
  @googleapi_hash = YAML.load_file(".googleapi.yaml")

  API_VERSION = 'v3'
  CACHED_API_FILE = "calendar-#{API_VERSION}.cache"
  CALENDAR_ID = @googleapi_hash["calendarId"]


	def gcal_event_insert(doctor_id, name, type_of_doctor, dt_start, dt_end)
		logger = Logger.new('logfile.log')
		doctor_id = doctor_id.to_s
		print CALENDAR_ID
		print "\n"
		print calendar
		print "\n"
		params = {
			calendarId: CALENDAR_ID
		}
		result = client.execute(
			:api_method => calendar.events.insert,
			:parameters => params,
			:body_object => convert_to_gcal_event(doctor_id, name, type_of_doctor, dt_start, dt_end)
		)
		logger.debug(result.data.to_yaml)
	end

	def gcal_event_update(doctor_id, name, type_of_doctor, dt_start, dt_end)
		logger = Logger.new('logfile.log')
		doctor_id = doctor_id.to_s
		event_id = make_event_id(doctor_id, dt_start)
		params = {
			calendarId: CALENDAR_ID,
			eventId: event_id
		}
		result = client.execute(
			:api_method => calendar.events.update,
			:parameters => params,
			:body_object => convert_to_gcal_event(doctor_id, name, type_of_doctor, dt_start, dt_end)
		)
		logger.debug(result.data.to_yaml)
	end

	def gcal_event_delete(doctor_id, dt_start)
		logger = Logger.new('logfile.log')
		doctor_id = doctor_id.to_s
		event_id = make_event_id(doctor_id, dt_start)
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
	def convert_to_gcal_event(doctor_id, name, type_of_doctor, dt_start, dt_end)
		doctor_id = doctor_id.to_s
		event_id = make_event_id(doctor_id, dt_start)
		print dt_start
		print "\n"
		print dt_end
		print "\n"
		event = {
			'extendedProperties' => {
				'private' => {
					'doctor_id' => doctor_id
				}
			},
			'summary' => name,
			'description' => type_of_doctor,
			'start' => {
				'dateTime' => dt_start
			},
			'end' => {
				'dateTime' => dt_end
			},
			'id' => event_id
		}
		return event
	end

	def make_event_id(doctor_id, dt_start)
		event_id = doctor_id.to_s + dt_start.to_i.to_s
		return event_id
	end

	#not sure how we can use this to have each person see their own schedule... maybe make a new calendar just for them?
	def find_gcal_events_by_doctor(doctor_id)
		params = {
			calendarId: CALENDAR_ID,
		}
		result = client.execute(
			:api_method => calendar.events.list,
			:parameters => params
		)
		allEvents = result.data.items
		myEvents = []
		allEvents.each do |e|
			if (e.extendedProperties["private"]["doctor_id"] == doctor_id)
				myEvents << e
			end
		end
		return myEvents
	end

	def init_client
		@googleapi_hash = YAML.load_file(".googleapi.yaml")	

		client0 = Google::APIClient.new(:application_name => 'ER-Core-Staff-Scheduler', :application_version => '1.0.0')

		# Load our credentials for the service account
		#key = Google::APIClient::KeyUtils.load_from_pkcs12(Rails.application.secrets.key_file, Rails.application.secrets.key_secret)
		key = Google::APIClient::KeyUtils.load_from_pkcs12(@googleapi_hash["key_file"], @googleapi_hash["key_secret"])
		#key = Google::APIClient::KeyUtils.load_from_pkcs12(".keyfile.p12", "notasecret")
		client0.authorization = Signet::OAuth2::Client.new(
			:token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
			:audience => 'https://accounts.google.com/o/oauth2/token',
			:scope => 'https://www.googleapis.com/auth/calendar',
			:issuer => @googleapi_hash["service_account_email"],
			#:person => @googleapi_hash["impersonate_user_email"],
			:signing_key => key)
		client0.authorization.fetch_access_token!
		print("THIS IS MY ACCESS TOKEN \n")
		print(client0.authorization.access_token)
		print "\n"
		if client0.authorization.access_token.nil?
			print "token is nil"
		end
		return client0
	end

	def init_calendar
		# Load cached discovered API, if it exists. This prevents retrieving the
		# discovery document on every run, saving a round-trip to the discovery service.
		if File.exists? CACHED_API_FILE
			print "cached"
			File.open(CACHED_API_FILE) do |file|
			calendar = Marshal.load(file)
			end
		else
			calendar = client.discovered_api('calendar', API_VERSION)
			File.open(CACHED_API_FILE, 'w') do |file|
				Marshal.dump(calendar, file)
			end
		end
	end

	def client
		client ||= init_client
	end

	def calendar
		calendar ||= init_calendar
	end


end