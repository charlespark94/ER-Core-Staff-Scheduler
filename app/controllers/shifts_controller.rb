class ShiftsController < ActionController::Base
  include Calendar

  def index
    @shifts = Shift.all
    @client = client
    service = @client.discovered_api('calendar', 'v3')
    event = {
      'summary' => 'Appointment',
      'location' => 'Somewhere',
      'start' => {
        'dateTime' => '2015-04-03T10:00:00.000-07:00'
      },
      'end' => {
        'dateTime' => '2015-04-03T10:25:00.000-07:00'
      }
      }
    result = client.execute(:api_method => service.events.insert,
                        :parameters => {'calendarId' => 'primary'},
                        :body => JSON.dump(event),
                        :headers => {'Content-Type' => 'application/json'})
    #@calendar = get_calendar
  end

  def new
    #@shift = Shift.new
  end


  def create
    @shift = Shift.create!(params[:shift])
    flash[:notice] = "Shift was successfully created."
    redirect_to shifts_path
  end
  
  def update
    @shift = Shift.find params[:id]
    @shift.update_attributes!(params[:shift])
    flash[:notice] = "Shift was successfully updated."
    redirect_to shifts_path()
  end

  def destroy
    @shift = Shift.find(params[:id])
    @shift.destroy
    flash[:notice] = "Shift deleted."
    redirect_to shifts_path
  end
end
