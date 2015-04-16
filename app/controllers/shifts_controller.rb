class ShiftsController < ActionController::Base
  include Calendar
  def index
    @shifts = Shift.all
    @hours_per_person = show_hours_per_person
    #@shifts.each do |shift|
    #  if shift.ingcal == true
    #    next
    #  else
    #    dt_start = shift.shiftstart
    #    dt_end = shift.shiftend
    #    dt_doc = shift.owner
    #    gcal_event_insert(0, dt_doc, "core", dt_start, dt_end)
    #    shift.ingcal = true
    #    shift.save!
    #  end
    #end
  end

  def new
    #@shift = Shift.new
  end

  def show
    @shift = Shift.find params[:id]
  end

  def edit
    @shift = Shift.find params[:id]
  end

  def create
    @shift = Shift.create!(params[:shift])
    flash[:notice] = "Shift was successfully created."
    dt_start = @shift.shiftstart
    dt_end = @shift.shiftend
    dt_doc = @shift.owner
    gcal_event_insert(0, dt_doc, "core", dt_start, dt_end)
    @shift.ingcal = true
    @shift.save!
    redirect_to shifts_path
  end
  
  def update
    @shift = Shift.find params[:id]
    old_start = @shift.shiftstart
    old_user = @shift.owner
    if old_user == '***' || old_user = "" ||old_user = " " || old_user.nil?
      delete_id = 0
    else
      delete_id = User.find_by_first_name(old_user)
    end
    @shift.update_attributes!(params[:shift])
    dt_start = @shift.shiftstart
    dt_end = @shift.shiftend
    dt_doc = @shift.owner  
    if (!@shift.users.nil? || !@shift.possible_users.nil?) &&(!dt_doc.nil?)
      gcal_event_delete(delete_id, old_start)
      gcal_event_insert(User.find_by_first_name(dt_doc).id, dt_doc, "core", dt_start, dt_end )
    else
      gcal_event_delete(delete_id, old_start)
      gcal_event_insert(0, dt_doc, "core", dt_start, dt_end)
    end

    #if dt_doc == "***" || dt_doc == nil
    #  gcal_event_update(0, dt_doc, "core", dt_start, dt_end)
    #else   
    #  gcal_event_insert(User.find_by_first_name(dt_doc).id, dt_doc, "core", dt_start, dt_end )
    #  gcal_event_delete(0, dt_start)
    #end
    flash[:notice] = "Shift was successfully updated."
    redirect_to shift_path(@shift)
  end

  def destroy
    @shift = Shift.find(params[:id])
    dt_start = @shift.shiftstart
    if @shift.owner == '***' || @shift.owner == "" || @shift.owner.nil? || @shift.owner == " "
      gcal_event_delete(0, dt_start)
    else
      dt_doc = @shift.owner
      gcal_event_delete(User.find_by_first_name(dt_doc).id, dt_start)
    end
    @shift.destroy
    flash[:notice] = "Shift deleted."
    redirect_to shifts_path
  end

  def show_hours_per_person
    users = User.all
    hours_per_person = {"***" => [0, 0]}
    #add each person into the hash with 0 hours initially
    users.each do |user|
      #we prob should change it so that the owner name is full name or something instead, because there mgiht be two johns
      full_name = user.first_name #+ " " + user.last_name
      hours_per_person[full_name] = [0, (user.fte*80).to_i]
    end

    # printing purposes
    # hours_per_person.each do |key, value|
    #   printf key.to_s + " " + value.to_s
    #   printf "\n"
    # end

    shifts = Shift.all
    #add each shift's time to their respective individual in the hash
    shifts.each do |shift|
      # I wanted to avoid using if else here to get a better runtime, but there's a user with no name
      if hours_per_person.has_key?(shift.owner)
        hours_per_person[shift.owner][0] = hours_per_person[shift.owner][0] + ((shift.shiftend - shift.shiftstart)/(60*60)).to_i
      else
        hours_per_person[shift.owner] = [((shift.shiftend - shift.shiftstart)/(60*60)).to_i, 0]      
      end
    end
    return hours_per_person
  end
end
