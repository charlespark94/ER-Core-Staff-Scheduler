class AddMoreUsers < ActiveRecord::Migration
  MORE_USERS = [
  	{:name => 'Bob', :usertype => 'core', :username => 'bobid', :password => 'bobpass', :fte => 0.2},
  	{:name => 'Jen', :usertype => 'admin', :username => 'jenid', :password => 'jenpass', :fte => 1.0},
  	{:name => 'Tonia', :usertype => 'core', :username => 'toniaid', :password => 'toniapass', :fte => 1.0}
  ]
  def up
  	MORE_USERS.each do |user|
  	  User.create!(user)
  	end
  end

  def down
  	MORE_USERS.each do |user|
  	  User.find_by_username_and_password(user[:username], user[:password]).destroy
  	end
  end
end
