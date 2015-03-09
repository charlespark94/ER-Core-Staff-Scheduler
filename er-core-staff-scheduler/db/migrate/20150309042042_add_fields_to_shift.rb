class AddFieldsToShift < ActiveRecord::Migration
  def change
    add_column :shifts, :starttime, :string
    add_column :shifts, :shiftlength, :integer
    add_column :shifts, :users, :string[]
    add_column :shifts, :owner, :string
    add_column :shifts, :open, :boolean
  end
end
