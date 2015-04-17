class Availability < ActiveRecord::Base
  attr_accessible :user_id, :shift_id, :availability
  belongs_to :user
  belongs_to :shift
end
