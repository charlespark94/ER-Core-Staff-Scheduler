Feature: view and modify availabilities in a calendar view

  As a user of the scheduler app
  So that I can easily set my availabilities
  I want to be able to choose my individual shift preferences in a calendar form
  
Background: I am on the availabilities page

 Given the following shifts exist:
  | shiftstart                 | shiftend                |
  | 2015-03-08 07:00:00 UTC    | 2015-03-08 19:00:00 UTC |   
  | 2015-03-08 11:00:00 UTC    | 2015-03-08 19:00:00 UTC |       
  | 2015-03-08 14:00:00 UTC    | 2015-03-08 22:00:00 UTC |      
  | 2015-03-08 19:00:00 UTC    | 2015-03-09 07:00:00 UTC |       
  | 2015-03-09 07:00:00 UTC    | 2015-03-09 19:00:00 UTC |      
  | 2015-03-09 10:00:00 UTC    | 2015-03-09 18:00:00 UTC |

  And that I am on the availabilities page
  
  Scenario: user can select availabilities from calendar form
    When I choose "yes" for shift: 1
    And I choose "maybe" for shift: 2
    And I choose "no" for shift: 4
    And I press "Update"
    Then I should be redirected to the availabilities page
    And I should see that "shift 1" reads "yes"
    And I should see that "shift 2" reads "maybe"
    And I should see that "shift 3" reads ""
    And I should see that "shift 4" reads "no"
    
  Scenario: user can see other user's availabilities
    When I choose "view other users' availabilities"
    Then I should see a calendar representation of all contents of the "Availabilities" table
