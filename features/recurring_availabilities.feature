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
  When I press "login_submit"
  Then I should be redirected to the home page
  Given that I am on the verified page
  Then I should see "The account has been verified and added to the application"
  Given the following shifts exist:
  | shiftstart                 | shiftend                | possible_users |
  | 2015-04-02 07:00:00 UTC    | 2015-04-02 19:00:00 UTC | ["admin"]      |
  | 2015-04-02 10:00:00 UTC    | 2015-04-02 18:00:00 UTC |                |
  | 2015-04-02 14:00:00 UTC    | 2015-04-02 22:00:00 UTC | ["admin"]      |
  | 2015-04-16 07:00:00 UTC    | 2015-04-16 19:00:00 UTC |                |
  | 2015-04-16 10:00:00 UTC    | 2015-04-16 18:00:00 UTC |                |
  | 2015-04-16 14:00:00 UTC    | 2015-04-16 22:00:00 UTC |                |

  And that I am on the availabilities page

Scenario: user can choose yes as their availability
  When I follow "Set Availabilities to Previous Pay Period" 
  Then I should be redirected to the availabilities new page
  And I should see that "possibleusers" equals ["[\"admin\"]", "", "[\"admin\"]", "", "", ""]