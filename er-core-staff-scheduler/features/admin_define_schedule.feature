Feature: admin define shift schedule

  As an admin of the scheduler app
  So that I can set shift coverage during the pay period 
  I want to be able to define a list of all available shifts for the pay period that must be filled

Background: I am an admin user

  Given that I am signed in
  And I am an admin user

Scenario: admin can input shift schedule
  When I am on the "input schedule" page
  I should see a datetime select field labeled "ShiftStart"
  And I should see a datetime select field labeled "ShiftEnd"
  And I should see a button labeled "Save"

Scenario: admin can view shifts they have added
  Given that "ShiftStart" is "2015/March/12/03/00"
  And "ShiftEnd" is "2015/March/12/07/00"
  And I press "Save"
  Then I should be redirected to the "input schedule" page
  And I should see starttime is "2015-03-12 03:00:00"
  And I should see endtime is "2015-03-12 07:00:00"