# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

SHIFTS = [
  {:shiftstart => DateTime.strptime("03/30/2015 07:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/30/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/30/2015 11:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/30/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/30/2015 14:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/30/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/30/2015 19:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/31/2015 07:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/31/2015 07:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/31/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/31/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/31/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/31/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/31/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/31/2015 14:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/31/2015 2:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/31/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/31/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/31/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("03/31/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("03/31/2015 19:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/01/2015 07:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/01/2015 07:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/01/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/01/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/01/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/01/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/01/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/01/2015 14:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/01/2015 2:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/01/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/01/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/01/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/01/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/01/2015 19:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/02/2015 07:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/02/2015 07:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/02/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/02/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/02/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/02/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/02/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/02/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/02/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/02/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/02/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/02/2015 19:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/03/2015 07:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/03/2015 07:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/03/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/03/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/03/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/03/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/03/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/03/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/03/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/03/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/03/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/03/2015 19:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/04/2015 07:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/04/2015 07:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/04/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/04/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/04/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/04/2015 10:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/04/2015 18:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/04/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/04/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/04/2015 18:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/04/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/04/2015 19:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/05/2015 07:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/05/2015 07:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/05/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/05/2015 11:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/05/2015 19:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/05/2015 14:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/05/2015 22:00", "%m/%d/%Y %H:%M")},
  {:shiftstart => DateTime.strptime("04/05/2015 19:00", "%m/%d/%Y %H:%M"),
   :shiftend => DateTime.strptime("04/06/2015 07:00", "%m/%d/%Y %H:%M")}
]

SHIFTS.each do |shift|
  Shift.create!(shift)
end