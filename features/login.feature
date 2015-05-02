Feature: login to the schedular app
  As an user of the scheduler app
  So that I can identify myself 
  I want to be able to login to my account

Background: I am on the login page and I exist in the database  
  Given 'admin' has been added to the database
  Given that I am on the login page

Scenario: user can enter their username and password to login
  When I fill in "username" with "admin"
  And I fill in "password" with "admin"
  When I press "Log In"
  Then I should be redirected to the home page
  When I go to the login page
  Then I should be redirected to the home page

Scenario: user is redirected to the login page when the username is wrong
  When I fill in "username" with "admin-false"
  And I fill in "password" with "admin"
  When I press "Log In"
  Then I should be redirected to the login page

Scenario: user is redirected to the login page when the password is wrong
  When I fill in "username" with "admin"
  And I fill in "password" with "admin-false"
  When I press "Log In"
  Then I should be redirected to the login page

Scenario: user can logout
  When I fill in "username" with "admin"
  And I fill in "password" with "admin"
  When I press "Log In"
  Then I should be redirected to the home page
  When I go to the logout page
  Then I should be redirected to the login page
  When I go to the home page
  Then I should be redirected to the login page