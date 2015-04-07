Feature:
	In order to verify the users of this application
	As an admin
	I want to be able to verify users when they create an account

Background:
    Given that I am on the signup page

Scenario: Verifiy Account
	When I fill in "user_first_name" with "Charles"
  	And I fill in "user_last_name" with "Park"
  	And I select "Core Doctor" from "user_usertype"
  	And I select "0.8" from "user_fte"
  	And I fill in "user_email" with "example@example.com"
  	And I fill in "user_username" with "core"
  	And I fill in "user_password" with "core"
  	And I fill in "user_password_confirmation" with "core"
  	When I press "signup_submit"
  	Then I should be redirected to the verification page
    Then I should see "Email sent to admin for verification"
    And "admin@example.com" should have an email
    When I open the email
    Then I should see "Verification for the user" in the email body
    When I click the first link in the email
    Then I should be on the verification complete page
    When I go to the login page
    And I fill "username" with "core"
    And I fill "password" with "core"
    And I press "login_submit"
    Then I should be redirected to the home page