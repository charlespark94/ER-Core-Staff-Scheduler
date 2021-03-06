Feature: set current shift preference to previous pay period preferences
 
  As an user of the scheduler app
  So that I can set my availability
  I want to be able to set my current availability to be the same availability as the previous pay period

Background: I am on the availabilities page
  
 Background: I am on the availabilities page
  
  Given 'admin' has been added to the database
  Given that I am on the login page
  When I fill in "username" with "admin"
  And I fill in "password" with "admin"
  When I press "Log In"
  Then I should be redirected to the home page
  Given that I am on the verified page
  Then I press "Update"
  Then I should see "The account has been verified and added to the application"
  Given the following shifts exist:
  | shiftstart                 | shiftend                | possible_users |
  | 2015-04-16 07:00:00 UTC    | 2015-04-16 19:00:00 UTC | ["admin"]      |
  | 2015-04-30 07:00:00 UTC    | 2015-04-30 19:00:00 UTC |                |
  And the following flag exist:
  | flagstart                  | recurring   |
  | 2015-04-19 00:00:00 UTC    | true        |
  And the following availabilities exist:
  |user_id |shift_id|id|
  |1       |1       |2 |
  |1       |2       |0 |


  And that I am on the availabilities page

Scenario: user can choose yes as their availability
  When I follow "Set Availabilities to Previous Pay Period"
  Then I should be redirected to the availabilities new page
  And I should see that "possibleusers" equals []