class User < ActiveRecord::Base
  attr_accessible :name, :usertype, :username, :password, :fte

  def self.usertype
  	['core', 'admin']
  end

  def self.fte
  	[0.1, 0.2, 0.35, 0.4, 1.0]
  end
end
