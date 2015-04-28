Feature: admin define shift schedule

  As an admin of the scheduler app
  So that I can set shift coverage during the pay period 
  I want to be able to define a list of all available shifts for the pay period that must be filled

Background:
  Given 'admin' has been added to the database
  Given I am logged in as 'admin' with password 'admin'
  Given that I am on the verified page
  Then I should see "The account has been verified and added to the application"
  Given the following flag exist:
  | flagstart                  | recurring   |
  | 2015-04-26 00:00:00 UTC    | true        |
  Given that I am on the input schedule page

Scenario: admin can input shift schedule
  Then I should see a date select field labeled "Start"
  And I should see a date select field labeled "End"
  And I should see a time select field labeled "Time Start"
  And I should see a time select field labeled "Time End"
  And I should see a button labeled "add_shift"

Scenario: admin can view shifts they have added
  When I fill in the date select field labeled "Start" with "2015-04-01T10:00:00"
  And I select "1" from "length_length"
  When I press "save_submit"
  Then I should be redirected to the shift index page
  And I follow edit for shift 1
  Then I should be redirected to the edit page for shift 1
  When I press "Delete"
  Then I should delete the shift for 04 - 01 starting at 00 from google
  Then I should be redirected to the shift index page 
