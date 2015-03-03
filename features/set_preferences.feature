Feature: set preferences by the length of shift
 
  As an user of the scheduler app
  So that I can set my preferences
  I want to be able to select my shift based on the hrs 

Background: I am on the shifts page
  
  Given that I am on the "shifts" page

Scenario: user can select their preferred shift length
  When I select "desired shift" of "length" 4
  And I should see that "desired_shift" of "length" 4 is selected
  Then I should see all available "shifts" of "length" 4

Scenario: user can select preference options for a given length of shift
  Given that I have selected "desired_shift" 
  Then I should be able to select: "Yes" or "Maybe" for "shift_option" for each "shift"
  And I press "preference_submit"
  Then I should see my "need_x_hours" decrease by that "length"

Scenario: user can reject preference optio for a given length of shift
  Given that I have selected "desired_shift"
  Then I should be able to select: "No" for "shift_option" for every "shift"
  And I press "preference_submit"
  Then I should see that my "need_x_hours" stays the same