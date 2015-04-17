Feature: Assign doctor to shifts

As an Admin
So that I can schedule availabilities
I want to be able to assign doctors to shifts

Background:
  Given 'admin' has been added to the database
  Given that I am signed in
  And I am an admin user
  Given the following users exist:
  |first_name  |
  |"admin"     |
  |"Jason"     |
  Given the following shifts exist:
  | shiftstart                 | shiftend                |
  | 2015-04-14 07:00:00 UTC    | 2015-04-14 19:00:00 UTC |
  | 2015-04-14 10:00:00 UTC    | 2015-04-14 18:00:00 UTC |
  | 2015-04-14 14:00:00 UTC    | 2015-04-14 22:00:00 UTC |
  Given 'admin' chooses yes on the shift 1 at availabilities page


  And that I am on the shift index page

Scenario: Admin sees possible doctors for shift
  When I follow edit for shift 1
  Then I should be redirected to the show page for shift 1
  Then I should see the users is ["admin"]
  When I follow "Edit"
  Then I should be redirected to the edit page for shift 1
  Then I should see a dropdown menu for Assign Person
  Then I select admin for Assign Person
  When I press "Update Shift"
  Then I should be redirected to the show page for shift 1
  Then I should see the owner is "admin"
