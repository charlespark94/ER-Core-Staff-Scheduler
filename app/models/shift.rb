class Shift < ActiveRecord::Base
  attr_accessible :shiftstart, :shiftend, :users, :possible_users, :owner, :ingcal
  has_many :availabilities, dependent: :destroy
  has_one :shift, :through => :avaliabilities
end
