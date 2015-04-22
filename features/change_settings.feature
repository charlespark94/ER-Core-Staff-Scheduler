Feature: Change account information
	As a User
	So that I can change my account information
	I would like to be able to change my settings

Background:
	Given I am logged in
	And I am on the settings page

Scenario: user can change password
	Given I fill in current password with "password"
	And I fill in new password with "new"
	And I press 'Update'
	Then if I logout
	And login with "new"
	Then I should see the home page

Scenario: user can change FTE
	Given I change FTE to 1.0
	And I press 'Update'
	When I go to the home page
	Then I should see "FTE of 1.0"