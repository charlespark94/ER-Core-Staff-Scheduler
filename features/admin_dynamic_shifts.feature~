Feature:
As an Admin
So that I can have dynamic and robust shifts
I want to be able to set shifts in the calendar

Background: Given I am logged in as an admin
  And the following shifts exist:
  | shiftstart                 | shiftend                |
  | 2015-03-08 07:00:00 UTC    | 2015-03-08 19:00:00 UTC |
  | 2015-03-08 11:00:00 UTC    | 2015-03-08 19:00:00 UTC |    
  | 2015-03-08 14:00:00 UTC    | 2015-03-08 22:00:00 UTC |    
  | 2015-03-08 19:00:00 UTC    | 2015-03-09 07:00:00 UTC |      
  | 2015-03-09 07:00:00 UTC    | 2015-03-09 19:00:00 UTC |    
  | 2015-03-09 10:00:00 UTC    | 2015-03-09 18:00:00 UTC |

Scenario: Add shift for all doctors to see in their availability
  Given that I am on the shift index page
  And I follow "Add new shift"
  Then I should be on the input schedule page
  When I add a shift for 04 - 08 from 12:00 to 20:00
  Then I should be redirected to the shift index page

Scenario: Set shift for administrative work
  Given that I am on the availabilities page
  When I choose "yes" of shift: 5
  And I choose "maybe" of shift: 3, 5
  And I choose "no" of shift: 6
  And I press "Update"
  Then I should be redirected to the availabilities page
  And I should see that "shiftuser" equals ["1", "", "", "", "", ""]
  And I should see that "possibleusers" equals ["1", "1", "1", "1", "1", ""]

Scenario: Delete shift from available shifts
  Given that I am on the shift index page
  And I follow edit for shift 1
  Then I should be redirected to the show page for shift 1
  When I press "Delete"
  Then I should be redirected to the shift index page 
