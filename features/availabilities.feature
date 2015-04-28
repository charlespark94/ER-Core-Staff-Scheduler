Feature: set availablility for each shift
 
  As an user of the scheduler app
  So that I can set my availability
  I want to be able to check the availability for each shift 

Background: I am on the availabilities page
  
  Given 'admin' has been added to the database
  Given that I am on the login page
  When I fill in "username" with "admin"
  And I fill in "password" with "admin"
  When I press "Log In"
  Then I should be redirected to the home page
  Given that I am on the verified page
  Then I should see "The account has been verified and added to the application"
  Given the following shifts exist:
  | shiftstart                 | shiftend                |
  | 2015-04-30 07:00:00 UTC    | 2015-04-30 19:00:00 UTC |   
  | 2015-04-30 10:00:00 UTC    | 2015-04-30 18:00:00 UTC |       
  | 2015-04-30 14:00:00 UTC    | 2015-04-30 22:00:00 UTC |
  And the following flag exist:
  | flagstart                  | recurring   |
  | 2015-04-26 00:00:00 UTC    | true        |

  And that I am on the availabilities page

Scenario: user can choose yes as their availability
  When I choose "yes" of shift: 1,2,3
  And I press "Update"
  Then I should be redirected to the availabilities page


Scenario: user can choose maybe as their availability
  When I choose "maybe" of shift: 1,2,3
  And I press "Update"
  Then I should be redirected to the availabilities page

Scenario: user can choose no as their avaialbility
  When I choose "no" of shift: 1,2,3
  And I press "Update"
  Then I should be redirected to the availabilities page