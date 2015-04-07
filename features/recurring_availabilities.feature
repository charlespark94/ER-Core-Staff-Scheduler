Feature: Add Recurring Availability

  As an user of the scheduler app
  So that I expedite the process of selecting shifts
  I want to be able to copy over my availabilites from my previous pay period

  Background: I am on the availabilities page

  Given the following shifts exist:
  | shiftstart                 | shiftend                |
  | 2015-03-30 07:00:00 UTC    | 2015-03-30 19:00:00 UTC |   
  | 2015-03-30 10:00:00 UTC    | 2015-03-30 18:00:00 UTC |       
  | 2015-03-30 14:00:00 UTC    | 2015-03-30 22:00:00 UTC |

 Scenario: User can select their current availability based on their previous pay period 
 When I press "Set availability of previous pay period"
 And the previous "shiftuser" equals ["1", "1", "1"]
 Then I should see that the current "shiftuser" equals ["1", "1", "1"]