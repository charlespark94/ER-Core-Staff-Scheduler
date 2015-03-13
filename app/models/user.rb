class User < ActiveRecord::Base
  attr_accessible :name, :usertype, :username, :password, :password_confirmation, :fte

  attr_accessor :password
  before_save :encrypt_password

  validates :name, :presence => true
  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true, :confirmation => true

  def self.authenticate(username="", login_password="")
  	user = find_by_username(username)
  	if user && user.match_password(login_password)
      user
  	else
  	  nil
  	end
  end

  def encrypt_password
    self.encrypted_password = BCrypt::Password.create(password) if password.present?
  end

  def match_password(login_password="")
    BCrypt::Password.new(encrypted_password) == login_password
  end
end
