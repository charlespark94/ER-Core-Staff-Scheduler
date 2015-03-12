Feature: login to the schedular app
 
  As an user of the scheduler app
  So that I can identify myself 
  I want to be able to login to my account

Background: I am on the login page
  
  Given that I am on the login page

Scenario: user can enter their username and password to login
  When I fill in "username" with "admin"
  And I fill in "password" with "admin"
  When I press "login_submit"
  Then I should be redirected to the home page

Scenario: user is redirected to the login page when the username is wrong
  When I fill in "username" with "admin-false"
  And I fill in "password" with "admin"
  When I press "login_submit"
  Then I should be redirected to the login page

Scenario: user is redirected to the login page when the password is wrong
  When I fill in "username" with "admin"
  And I fill in "password" with "admin-false"
  When I press "login_submit"
  Then I should be redirected to the login page

Scenario: user can logout
  When I fill in "username" with "admin"
  And I fill in "password" with "admin"
  When I press "login_submit"
  Then I should be redirected to the home page
  When I go to the logout page
  Then I should be redirected to the login page

Scenario: user can create an account
  When I go to the signup page
  Then I should be redirected to the signup page
  When I fill in "name" with "Charles Park"
  And I select "Core Doctor" from "user_usertype"
  And I select "0.8" from "user_fte"
  And I fill in "user_username" with "core"
  And I fill in "user_password" with "core"
  And I fill in "user_password_confirmation" with "core"
  When I press "signup_submit"
  Then I should be redirected to the login page
  When I fill in "username" with "core"
  And I fill in "password" with "core"
  Then I should be redirected to the home page