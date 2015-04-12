class CreateAvailabilities < ActiveRecord::Migration
  def change
  	create_table :availabilities do |a|
  		a.belongs_to :user
  		a.belongs_to :shift
  		a.integer :availability
  	end
  end
end
