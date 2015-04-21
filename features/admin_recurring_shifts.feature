Feature: Recurring Shifts

	As an Admin
	So that I can use last pay period's shift template
	I want a button that allows me to copy last week's pay period.

Background: Given the following shifts exist:
| shiftstart                 | shiftend                  |
| 2015-04-06 07:00:00 PST    | 2015-04-06 19:00:00 PST   |

And I am logged in as an admin
And I am on the shift index page

Scenario: Repeating last pay period's shift template

When I click "recurring shifts" 
Then I should be redirected to the shift index page
And I should see a shift for 2015-04-20 07:00:00 PST to 2015-04-20 19:00:00 PST
