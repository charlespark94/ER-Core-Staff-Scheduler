Feature: admin define shift schedule

  As an admin of the scheduler app
  So that I can set shift coverage during the pay period 
  I want to be able to define a list of all available shifts for the pay period that must be filled

Background: I am an admin user

  Given that I am signed in
  And I am an admin user

Scenario: admin can input shift schedule
  When I am on the "input schedule" page
  Then I should see a date select field labeled "Start"
  And I should see a date select field labeled "End"
  And I should see a time select field labeled "Time Start"
  And I should see a time select field labeled "Time End"
  And I should see a button labeled "add_shift"

Scenario: admin can view shifts they have added
  Given that "Start" is "1/1/16"
  And "End" is "1/1/16"
  And "Time Start" is "07:00"
  And "Time End" is "19:00"
  And I press "add_shift"
  Then I should be redirected to the "input schedule" page
  And I should see "1/1/16 07:00 - 1/1/16 19:00"
