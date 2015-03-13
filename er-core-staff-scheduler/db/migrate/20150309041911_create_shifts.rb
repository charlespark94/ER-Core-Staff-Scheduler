class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
    	t.datetime :shiftstart
    	t.datetime :shiftend
    	t.string :users, array: true
    	t.string :possible_users, array: true
    	t.string :owner, default: '***'
    end
  end
end
