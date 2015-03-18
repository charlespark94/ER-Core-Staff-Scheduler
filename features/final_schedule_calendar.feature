Feature: finalize doctor schedule in google calendar form

	As an admin of the schedule app
	So that I can finalize this payment period's schedule
	I want to be able to save the final schedule in google calendar that everyone will see

Background: I am on the home page

 Given the following shifts are set:
  | shiftstart                 | shiftend                | assigned person  |
  | 2015-03-08 07:00:00 UTC    | 2015-03-08 19:00:00 UTC | David Pei        |
  | 2015-03-08 11:00:00 UTC    | 2015-03-08 19:00:00 UTC | Jason Kim        |
  | 2015-03-08 14:00:00 UTC    | 2015-03-08 22:00:00 UTC | Jason Duval      |

  And that I am signed in as admin
  And that I am on the home page

Scenario: Admin can see the same schedule in Google Calendar
	When I clicked date 2015-03-08 on Google Calendar
	Then I should see the shift from 07:00:00 to 19:00:00 is assigned to David Pei
	And I should see the shift from 11:00:00 to 19:00:00 is assigned to Jason Kim
	And I should see the shift from 14:00:00 to 22:00:00 is assigned to Jason Duval