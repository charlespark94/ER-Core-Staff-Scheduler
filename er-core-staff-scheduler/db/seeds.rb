# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
USERS = [
  {:name => 'Bob', :usertype => 'core', :username => 'bobid', :password => 'bobpass', :fte => 0.2},
  {:name => 'Jen', :usertype => 'admin', :username => 'jenid', :password => 'jenpass', :fte => 1.0},
  {:name => 'Tonia', :usertype => 'core', :username => 'toniaid', :password => 'toniapass', :fte => 1.0}
]

USERS.each do |user|
  User.create!(user)
end

SHIFTS = [
  {:shiftstart => DateTime.strptime("03/08/2015 07:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/08/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/08/2015 11:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/08/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/08/2015 14:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/08/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/08/2015 19:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/09/2015 07:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/09/2015 07:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/09/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/09/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/09/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/09/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/09/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/09/2015 14:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/09/2015 2:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/09/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/09/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/09/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/09/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/09/2015 19:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/10/2015 07:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/10/2015 07:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/10/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/10/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/10/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/10/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/10/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/10/2015 14:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/10/2015 2:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/10/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/10/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/10/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/10/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/10/2015 19:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/11/2015 07:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/11/2015 07:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/11/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/11/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/11/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/11/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/11/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/11/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/11/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/11/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/11/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/11/2015 19:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/12/2015 07:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/12/2015 07:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/12/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/12/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/12/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/12/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/12/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/12/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/12/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/12/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/12/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/12/2015 19:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/13/2015 07:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/13/2015 07:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/13/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/13/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/13/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/13/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/13/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/13/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/13/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/13/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/13/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/13/2015 19:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/14/2015 07:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/14/2015 07:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/14/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/14/2015 11:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/14/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/14/2015 14:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/14/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/14/2015 19:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/15/2015 07:00", "%m/%d/%Y %H:%M")}
]

SHIFTS.each do |shift|
  Shift.create!(shift)
end