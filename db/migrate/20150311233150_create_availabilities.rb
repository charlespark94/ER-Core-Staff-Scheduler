class CreateAvailabilities < ActiveRecord::Migration
  def change
  	create_table :availabilities do |a|
  		a.references :user
  		a.references :shift
  		a.integer :availability
  	end
  end
end
