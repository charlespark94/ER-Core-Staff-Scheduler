Feature: Display Current Schedule
	As a User
	So that I can see this pay-period's schedule
	I want to see the current pay-period on the calendar for my shifts

Background: Given I have been added to the database
	
	Given 'admin' has been added to the database
	Given I am logged in as 'admin' with password 'admin'
	Then I should be logged in
	And I should be on the home page

Scenario: User can see calendar for two payment periods
	Then I should see the schedule for two payment periods