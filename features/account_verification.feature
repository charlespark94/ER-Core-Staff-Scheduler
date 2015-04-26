Feature:
	In order to verify the users of this application
	As an admin
	I want to be able to verify users when they create an account

Background:
    Given that I am not logged in
    And that I am on the signup page

Scenario: Verifiy Account
	When I fill in "user_first_name" with "Charles"
  	And I fill in "user_last_name" with "Park"
  	And I select "Core Doctor" from "user_usertype"
  	And I fill in "user_fte" with "0.8"
  	And I fill in "user_email" with "example@example.com"
  	And I fill in "user_username" with "core"
  	And I fill in "user_password" with "core"
  	And I fill in "user_password_confirmation" with "core"
  	When I press "signup_submit"
    Then I should be redirected to the login page
    When I fill in "username" with "core"
    And I fill in "password" with "core"
    And I press "login_submit"
  	Then I should be redirected to the not verified page
    Then I should see "Your account has not been verified yet. Please wait for the admin you verify your information"   
    And "vaverifyscheduler@gmail.com" should have an email
    When I open the email
    Then I should see "This email contains Verification Information" in the email body
    When I click the first link in the email
    Then I should be on the verification complete page
    When I go to the login page
    Then I should be redirected to the home page
    When I go to the not verified page
    Then I should be redirected to the home page