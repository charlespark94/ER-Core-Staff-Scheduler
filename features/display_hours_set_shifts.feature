Feature: Display Hour Amount of Assigned Shifts
	As an Admin
	So that I can allocate shifts properly
	I want to be able to see the current amount of hours I assigned to various doctors

Scenario: Admin can see hour amount change from assigning
	When I assign a shift of 10 hours to David Pei
	Then I will see total hours for David Pei go to 10 hours
	When I assign a shift of 8 hours to David Pei
	Then I will see total hours for David Pei go to 18 hours

Scenario: Admin can see hour amount change from reassigning
	Given I assign a shift of 10 hours to David Pei
	When I reassign a shift of 10 hours to Jason Kim
	Then I will see total hours for Jason Kim go to 10 hours
	And I will see total hours for David Pei go to 0 hours