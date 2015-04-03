class AddIngcalToShifts < ActiveRecord::Migration
  def change
  	add_column :shifts, :ingcal, :boolean, :default => false
  end
end
