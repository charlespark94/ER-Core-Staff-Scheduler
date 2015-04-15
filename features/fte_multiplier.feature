Feature: admine define fte multipier

  As an admin of the scheduler app
  So that I can get a fair availabilities preference from each doctor
  I want to be able to define a fte multiplier

Background: I am an admin user

  Given 'admin' has been added to the database
  Given that I am signed in
  And I am an admin user
  And that I am on the multiply page



Scenario: admin can input shift schedule
  When I fill in "1" with "2.5"
  And I press "Update"
  Then I should be redirected to the multiply page
  And I should have fte_multiplier of 2.5