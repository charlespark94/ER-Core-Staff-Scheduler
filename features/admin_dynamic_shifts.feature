Feature:
As an Admin
So that I can have dynamic and robust shifts
I want to be able to set shifts in the calendar

Background:
  Given 'admin' has been added to the database
  Given I am logged in as 'admin' with password 'admin'
  Given that I am on the verified page
  Then I should see "The account has been verified and added to the application"
  And the following shifts exist:
  | shiftstart                 | shiftend                |
  | 2015-03-08 07:00:00 UTC    | 2015-03-08 19:00:00 UTC |
  | 2015-03-08 11:00:00 UTC    | 2015-03-08 19:00:00 UTC |    
  | 2015-03-08 14:00:00 UTC    | 2015-03-08 22:00:00 UTC |    
  | 2015-03-08 19:00:00 UTC    | 2015-03-09 07:00:00 UTC |      
  | 2015-03-09 07:00:00 UTC    | 2015-03-09 19:00:00 UTC |    
  | 2015-03-09 10:00:00 UTC    | 2015-03-09 18:00:00 UTC |
  And the following flag exist:
  | flagstart                  | recurring   |
  | 2015-04-26 00:00:00 UTC    | true        |
  Given that I am on the shift index page

Scenario: Add shift for all doctors to see in their availability
  And I follow "Add new shift"
  Then I should be on the input schedule page
  When I add a shift for 04 - 08 from 12:00 to 20:00
  Then I should be redirected to the shift index page

Scenario: Delete shift from available shifts
  And I follow edit for shift 1
  Then I should be redirected to the edit page for shift 1
  When I press "Delete"
  Then I should delete the shift for 03 - 08 starting at 07 from google
  Then I should be redirected to the shift index page 
