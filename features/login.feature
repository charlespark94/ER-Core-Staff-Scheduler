Feature: login to the schedular app
 
  As an user of the scheduler app
  So that I can identify myself 
  I want to be able to login to my account

Background: I am on the login page
  
  Given that I am on the "login" page

Scenario: user can enter their username and password to login
  When I type my username "admin" in the "username" field
  Then the "username" field should contain "admin"
  And I type my password "admin" in the "password" field
  Then the "password" field should not be empty
  And I press "login_button"
  Then I should be redirected to "homepage" page

Scenario: user is notified when username or password is invalid
  When the "username" field is not "admin"
  And the "password" field is not "admin"
  Then I should be redirected to the "login" page
  And I should get an "invalid username/password" error