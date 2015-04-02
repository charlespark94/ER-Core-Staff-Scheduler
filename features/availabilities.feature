Feature: set availablility for each shift
 
  As an user of the scheduler app
  So that I can set my availability
  I want to be able to check the availability for each shift 

Background: I am on the availabilities page
  
  Given 'admin' has been added to the database
  Given that I am on the login page
  When I fill in "username" with "admin"
  And I fill in "password" with "admin"
  When I press "login_submit"
  Then I should be redirected to the home page
  Given the following shifts exist:
  | shiftstart                 | shiftend                |
  | 2015-03-30 07:00:00 UTC    | 2015-03-30 19:00:00 UTC |   
  | 2015-03-30 10:00:00 UTC    | 2015-03-30 18:00:00 UTC |       
  | 2015-03-30 14:00:00 UTC    | 2015-03-30 22:00:00 UTC |

  And that I am on the availabilities page

Scenario: user can choose yes as their availability
  When I choose "yes" of shift: 1,2,3
  And I press "Update"
  Then I should be redirected to the availabilities page
  And I should see that "shiftuser" equals ["1", "1", "1"]


Scenario: user can choose maybe as their availability
  When I choose "maybe" of shift: 1,2,3
  And I press "Update"
  Then I should be redirected to the availabilities page
  And I should see that "shiftuser" equals ["", "", ""]
  And I should see that "possibleusers" equals ["1", "1", "1"]

Scenario: user can choose no as their avaialbility
  When I choose "no" of shift: 1,2,3
  And I press "Update"
  Then I should be redirected to the availabilities page
  And I should see that "shiftuser" equals ["", "", ""]
  And I should see that "possibleusers" equals ["", "", ""]
