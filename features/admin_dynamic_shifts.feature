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
  Given I am on the shift index page
  And I follow "add shift"
  Then I am on the input schedule page
  And I add a shift for "April 1st" from 10:00 to 6:00
  Then I should be redirected to the shift index page 
  And I should see a shift for "April 1st" from 10:00 to 6:00

Scenario: Delete shift from available shifts
  Given I am on the shift index page
  And I follow "edit" for shift 1
  Then I should be redirected to the edit shift page
  And I should see a button labelled "Delete Shift"
  When I click "Delete Shift"
  Then I should be redirected to the shift index page 
  And I should not see shift 1


Scenario: Set shift for administrative work
  Given I am on the input schedule page
  And I add for "April 1st" from 6:00 to 8:00
  Then I should be redirected to the shift index page
  And I follow the "go home" button
  Then I should be redirected to the home page
  When I follow set availability
  Then I should be redirected to the set availability page
  When I choose 'yes' of shift: 8
  And I choose 'maybe' of shift: 4, 5
  And I choose 'no' of shift: 6
  Then I should be redirected to the availabilities page
  And I should see that "shiftuser" equals ["", "", "", "", "", "", "", "1"]
  And I should see that "possibleusers" equals ["1", "1", "1", "1", "1", "", "1", ""]
