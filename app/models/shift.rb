class Shift < ActiveRecord::Base
  attr_accessible :shiftstart, :shiftend, :users, :possible_users, :owner, :ingcal, :event_id
  has_many :availabilities
  has_many :users, :through => :availabilities
  before_create :create_unique_identifier

  def create_unique_identifier
  	begin
  		self.event_id = SecureRandom.hex(6)
  	end while self.class.exists?(:event_id => event_id)
  end

  def converted_shift
 	return self.shiftstart.in_time_zone('Pacific Time (US & Canada)')
  end
end
