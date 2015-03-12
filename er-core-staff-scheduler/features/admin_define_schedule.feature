Feature: admin define shift schedule

  As an admin of the scheduler app
  So that I can set shift coverage during the pay period 
  I want to be able to define a list of all available shifts for the pay period that must be filled

Background: I am an admin user

  Given that I am signed in
  And I am an admin user

Scenario: admin can input shift schedule
  When I am on the "input schedule" page
  Then I should see a datetime_select labeled ShiftStart
  Then I should see a datetime_select labeled ShiftEnd
  Then I should see a submit_tag labeled "Save"

Scenario: admin can view shifts they have added
  When I am on the "input schedule" page
  Then I fill in time shiftstart with 2015-March-12-03-00
  Then I fill in time shiftend with 2015-March-12-07-00
  And I press "Save"
  Then I should be redirected to the "shift index" page
  And I should see one starttime is 2015-03-12 03:00:00 UTC
  And I should see one endtime is 2015-03-12 07:00:00 UTC
  