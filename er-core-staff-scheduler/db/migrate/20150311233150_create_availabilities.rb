class CreateAvailabilities < ActiveRecord::Migration
  def change
  	create_table :availabilities do |a|
  		a.integer :id
  		a.integer :preferred, array: true
  		a.integer :maybe, array: true
  	end
  end
end
