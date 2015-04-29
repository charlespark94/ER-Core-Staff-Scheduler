Feature: Assign doctor to shifts

As an Admin
So that I can schedule availabilities
I want to be able to assign doctors to shifts

Background:
  Given 'admin' has been added to the database
  Given I am logged in as 'admin' with password 'admin'
  Given that I am on the verified page
  Then I should see "The account has been verified and added to the application"
  Given the following users exist:
  | first_name |
  | admin      |
  | Jason      |

  Given the following shifts exist:
  | shiftstart                 | shiftend                |
  | 2015-04-30 07:00:00 UTC    | 2015-04-30 19:00:00 UTC |
  | 2015-04-30 10:00:00 UTC    | 2015-04-30 18:00:00 UTC |
  | 2015-04-30 14:00:00 UTC    | 2015-04-30 22:00:00 UTC |
  And the following flag exist:
  | flagstart                  | recurring   |
  | 2015-04-26 00:00:00 UTC    | true        |
  Given that I am on the availabilities page
  And I choose "yes" of shift: 1,2,3
  And I press "Update"
  Given that I am on the shift index page
  And 'admin' has chosen yes on the shift 1 at availabilities page

Scenario: Admin sees possible doctors for shift
  When I follow edit for shift 1
  Then I should be redirected to the edit page for shift 1
  Then I should see the users is ["admin"]
  Then I should see a dropdown menu for Assign Doctor
  Then I select admin for Assign Person
  When I press "Update Shift"
