Feature: Assign doctor to shifts

As an Admin
So that I can schedule availabilities
I want to be able to assign doctors to shifts

Background:
  Given the following shfits exist:
  | shiftstart                 | shiftend                |
  | 2015-04-16 07:00:00 UTC    | 2015-04-16 19:00:00 UTC |   
  | 2015-04-16 10:00:00 UTC    | 2015-04-16 18:00:00 UTC |     
  | 2015-04-16 14:00:00 UTC    | 2015-04-16 22:00:00 UTC |
  

Scenario: Adding available doctors
  Given I am not logged in as an admin
  And that I am on the availabilities page
  When I choose "yes" of shift: 1,2
  And I choose "maybe" of shift: 3
  And I press "Update"
  Then I should be redirected to the availabilities page
  And I should see that "shiftuser" equals ["1", "1", ""]
  And I should see that "possibleusers" equals ["1", "1", "1"]

Scenario: Admin sees possible doctors for shift
  Given I am logged in as an admin
  And that I am on the shift index page
  When I follow edit for shift 3
  Then I should be redirected to the show page for shift 1
  When I follow "edit"
  Then I should be redirected to the edit page for shift 1
  And I should see a dropdown menu for "Assigned Doctor"
  When I select item 1
  And I press "save_submit" 
  Then I should be redirected to the shift index page
  And I should see item 1 under "assigned person" for shift 1
  
