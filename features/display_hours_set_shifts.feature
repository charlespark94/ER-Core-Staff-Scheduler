Feature: Display Hour Amount of Assigned Shifts
	As an Admin
	So that I can allocate shifts properly
	I want to be able to see the current amount of hours I assigned to various doctors

Background:
	Given 'admin' has been added to the database
	Given I am logged in as 'admin' with password 'admin'
	Given that I am on the verified page
	Then I should see "The account has been verified and added to the application"
    Given the following flag exist:
	| flagstart                  | recurring   |
	| 2015-04-19 00:00:00 UTC    | true        |
	And that I am on the availabilities page
	Given the following users exist:
	|first_name   |
	|"admin"	  |

    And the following shifts exist:
    | shiftstart                 | shiftend                |
    | 2015-04-30 07:00:00 UTC    | 2015-04-30 19:00:00 UTC |
    | 2015-04-30 10:00:00 UTC    | 2015-04-30 18:00:00 UTC |
    | 2015-04-30 14:00:00 UTC    | 2015-04-30 22:00:00 UTC |
	Given that I am on the availabilities page
	And I choose "yes" of shift: 1,2,3
	And I press "Update"
    And 'admin' has chosen yes on the shift 1 at availabilities page

Scenario: Admin can see hour amount change from assigning
	When I follow edit for shift 1
	Then I should be redirected to the edit page for shift 1
	Then I should see the users is ["admin"]
	Then I should see a dropdown menu for Assign Doctor
	Then I select admin for Assign Person
	When I press "Update Shift"
	Then I should see that "admin" has 0 hours assigned

Scenario: Admin can see hour amount change from reassigning
	When I follow edit for shift 1
	Then I should be redirected to the edit page for shift 1
	Then I should see the users is ["admin"]
 	When I press "Delete"
 	Then the shifts should be deleted
  	Then I should be redirected to the shift index page 
	And I should see that "admin" has 0 hours assigned