class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name
      t.string :usertype
      t.string :username
      t.string :password
      t.float :fte
      t.string :encrypted_password
    end
  end

  def down
  	drop_table :users
  end
end
