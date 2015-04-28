Feature: Password Reset
  In order to retrieve a lost password
  As a user of this site
  I want to reset it

Background: I exist in the databse, I am not logged in, and I am on the login page
    Given I go to the logout page
    Given 'admin' has been added to the database
    Given that I am on the login page

Scenario: Reset password
    When I follow "forgot_link"
    When I fill in "email" with "example@example.com"
    And I press "Reset Password"
    Then I should see "Email sent to example@example.com with password reset instructions"
    And "example@example.com" should have an email
    When I open the email
    Then I should see "Password Reset Instructions" in the email body
    When I click the first link in the email
    Then I should be on the new password page
    When I fill in "user_password" with "newpassword"
    And I fill in "user_password_confirmation" with "newpassword"
    And I press "Update Password"
    Then I should see "Password has been reset"
    When I fill in "username" with "admin"
    And I fill in "password" with "newpassword"
    And I press "Log In"
    Then I should be redirected to the home page


Scenario: Reset password no account
    When I follow "forgot_link"
    And I fill in "email" with "wrongemail@example.com"
    And I press "Reset Password"
    Then I should be redirected to the login page

Scenario: Reset password with expired token
    When I follow "forgot_link"
    When I fill in "email" with "example@example.com"
    And I press "Reset Password"
    Then I should see "Email sent to example@example.com with password reset instructions"
    And "example@example.com" should have an email
    When I open the email
    And I simulate waiting for 3 hours
    Then I should see "Password Reset Instructions" in the email body
    When I click the first link in the email
    Then I should be on the new password page
    When I fill in "user_password" with "newpassword"
    And I fill in "user_password_confirmation" with "newpassword"
    And I press "Update Password"
    Then I should see "Password reset has expired"

