Feature: Recurring Shifts

	As an Admin
	So that I can use last pay period's shift template
	I want a button that allows me to copy last week's pay period.

Background:
  Given 'admin' has been added to the database
  Given I am logged in as 'admin' with password 'admin'
  Given that I am on the verified page
  Then I press "Update"
  Then I should see "The account has been verified and added to the application"
  Given the following flag exist:
  | flagstart                  | recurring   |
  | 2015-03-08 00:00:00 UTC    | true        |
  Given that I am on the shift index page

Scenario: Recurring Shift Should Be Added
  Then I should see the shifts added to the page

