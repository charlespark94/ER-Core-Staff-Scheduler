Feature: Display Current Schedule
	As a User
	So that I can see this pay-period's schedule
	I want to see the current pay-period on the calendar for my shifts

Background: Given I just logged in
	Given I am logged in
	And I am on the home page

Scenario: User can see calendar for two payment periods
	Then I should see the calendar for two payment periods