class Shift < ActiveRecord::Base
  attr_accessible :shiftstart, :shiftend, :users, :possible_users, :owner, :ingcal, :event_id
  has_many :availabilities
  has_many :users, :through => :availabilities

end
