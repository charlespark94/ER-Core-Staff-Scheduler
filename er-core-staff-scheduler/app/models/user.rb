class User < ActiveRecord::Base
  attr_accessible :name, :usertype, :username, :password, :fte

  def self.all_usertype
  	['core', 'admin']
  end

  def self.all_fte
  	[0.1, 0.2, 0.35, 0.4, 1.0]
  end
end
