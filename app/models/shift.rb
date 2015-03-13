class Shift < ActiveRecord::Base
  attr_accessible :shiftstart, :shiftend, :users, :possible_users, :owner
end
