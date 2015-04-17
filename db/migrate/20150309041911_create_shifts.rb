class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
    	t.datetime :shiftstart
    	t.datetime :shiftend
    	t.string :users, array: true, default: " "
    	t.string :possible_users, array: true, default: " "
    	t.string :owner, default: '***'
    	t.string :event_id
    end
  end
end
