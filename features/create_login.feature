Feature: Create an account to login
  As an user of the scheduler app
  So that I can identify myself 
  I want to be able to create an account

Background: I am on the signup page  
  Given that I am on the signup page

Scenario: user can create an account
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
  Then I should be redirected to the home page

Scenario: user didn't fill out all fields for creating an account
  When I press "signup_submit"
  Then I should be redirected to the signup page