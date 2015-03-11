class User < ActiveRecord::Base
  attr_accessible :name, :usertype, :username, :password, :password_confirmation, :fte

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :username

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

  def self.all_usertype
  	['Core', 'Admin']
  end

  def self.all_fte
  	[0.1, 0.2, 0.35, 0.4, 1.0]
  end
end
