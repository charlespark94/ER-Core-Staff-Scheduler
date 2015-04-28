class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.datetime :flagstart
      t.boolean :recurring
    end
  end
end
