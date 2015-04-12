class Availability < ActiveRecord::Base
  attr_accessible :id, :preferred, :maybe
  belongs_to :user
end
