class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :usertype
      t.string :username
      t.string :password
      t.string :email
      t.string :auth_token
      t.float :fte, default: 1.0
      t.string :encrypted_password
      t.boolean :verified, default: false
      t.float :fte_multiplier, default: 1.0
    end
  end

  def down
  	drop_table :users
  end
end
