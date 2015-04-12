class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :usertype, :username, :password, :password_confirmation, :email, :fte, :verified
  has_many :availabilities, dependent: :destroy
  has_many :shifts, :through => :availabilities

  attr_accessor :password
  before_create { generate_token(:auth_token)}
  before_save :encrypt_password

  validates :first_name, :presence => true, :on => :create
  validates :last_name, :presence => true, :on => :create
  validates :email, email_format: { message: "doesn't look like an email address" }
  validates :username, :presence => true, :uniqueness => true, :on => :create
  validates :password, :presence => true, :confirmation => true, :on => :create

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

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def verifier
    self.update_attributes(:verified => true)
  end
end