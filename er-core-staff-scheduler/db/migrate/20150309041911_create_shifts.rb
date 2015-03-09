class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
    	t.string :starttime
    	t.shiftslength :integer
    	t.users :string[]
    	t.owner :string
    	t.open :boolean

      t.timestamps
    end
  end
end
