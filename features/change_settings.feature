Feature: Change account information
	As a User
	So that I can change my account information
	I would like to be able to change my settings

Background:
	Given 'admin' has been added to the database
	Given I am logged in as 'admin' with password 'admin'
	Given that I am on the verified page
  	Then I press "Update"
	Then I should see "The account has been verified and added to the application"
	Given that I am on the settings page

Scenario: user can change password
	Given I fill in "user_password" with "test"
	And I fill in "user_password_confirmation" with "test"
	When I press "Update"
	And I go to the logout page
	And I fill in "username" with "admin"
	And I fill in "password" with "test"
	Then I should be redirected to the home page

Scenario: user inputs wrong password confirmation
	Given I fill in "user_password" with "test"
	And I fill in "user_password_confirmation" with "testnot"
	When I press "Update"
	Then I should be redirected to the settings page
