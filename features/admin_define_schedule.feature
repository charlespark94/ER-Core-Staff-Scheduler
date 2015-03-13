Feature: admin define shift schedule

  As an admin of the scheduler app
  So that I can set shift coverage during the pay period 
  I want to be able to define a list of all available shifts for the pay period that must be filled

Background: I am an admin user

  Given 'admin' has been added to the database
  Given that I am signed in
  And I am an admin user

Scenario: admin can input shift schedule
  Given that I am on the input schedule page
  Then I should see a date select field labeled "Start"
  And I should see a date select field labeled "End"
  And I should see a time select field labeled "Time Start"
  And I should see a time select field labeled "Time End"
  And I should see a button labeled "add_shift"

#Scenario: admin can view shifts they have added
#  Given that I am on the input schedule page
#  And I fill in the date select field labeled "Start" with "2015-04-01T10:00:00"
#  And I fill in the date select field labeled "End" with "2015-04-01T18:00:00"
#  When I press "save_submit"
#  Then I should be redirected to the shift index page
#  And I should see "2015-04-01T10:00:00"
#  And I should see "2015-04-01T18:00:00"
