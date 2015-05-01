class Shift < ActiveRecord::Base
  attr_accessible :shiftstart, :shiftend, :users, :possible_users, :owner, :ingcal, :event_id
  has_many :availabilities
  has_many :users, :through => :availabilities
  before_create :create_unique_identifier
  before_save :delete_availabilities, if: :time_changed?

  def create_unique_identifier
  	begin
  		self.event_id = SecureRandom.hex(6)
  	end while self.class.exists?(:event_id => event_id)
  end

  def time_changed?
  	self.shiftstart_changed?
  end

  def delete_availabilities
  	self.availabilities.delete_all
  end

end
