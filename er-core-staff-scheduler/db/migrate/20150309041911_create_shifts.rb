class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|

      t.timestamps
    end
  end
end
