Feature: Display Google Calendar of Current Schedule
	As a User
	So that I can see the current pay period's schedule on the Home Page
	I want to see the Google Calendar for this page

	Background: I am on the home page
	
	Given the following shifts are set:
  	| shiftstart                 | shiftend                | user             | 
  	| 2015-03-08 03:00:00 UTC    | 2015-03-08 5:00:00 UTC  | Michelle Phung   |
  	| 2015-03-08 11:00:00 UTC    | 2015-03-08 15:00:00 UTC | Jason Kim        |
  	| 2015-03-08 16:00:00 UTC    | 2015-03-08 22:00:00 UTC | Charles Park     |

  	And the following users are set:

  	| name                   	 | usertype                | username         |
  	| Michelle Phung             | user 				   | michelle.phung   |

  	And I am logged in as michelle.phung 

	Scenario: See the current pay period in Google Calendar
	Then I should see 2015-03-08 the Google Calendar

	Scenario: See the User's shifts in Google Calendar
	When I press the "My Shift" button
	Then I should see the shift from 03:00:00 to 5:00:00 is assigned to Michelle Phung

	Scenario: See everyone else's shifts in Google Calendar
	When I press the "Everyone's Shifts" button
	Then I should see the shift from 03:00:00 to 5:00:00 is assigned to Michelle Phung
	Then I should see the shift from 11:00:00 to 15:00:00 is assigned to Jason Kim
	Then I should see the shift from 16:00:00 to 22:00:00 is assigned to Charles Park

	Scenario: See the link to Google Calendar
	Then I should see the link to Google Calendar  

