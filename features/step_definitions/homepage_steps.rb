Given /^'(.*)' has been added to the database$/ do |username|
  visit path_to('signup')
  step "I fill in \"First name\" with \"#{username}\""
  step "I fill in \"Last name\" with \"#{username}\""
  step "I fill in \"Username\" with \"#{username}\""
  step "I fill in \"Email\" with \"vacorescheduling@gmail.com\""
  step "I fill in \"Password\" with \"#{username}\""
  step "I fill in \"Password confirmation\" with \"#{username}\""
  step "I press \"signup_submit\""
end

Given /^(?:|I )am logged in as '(.*)' with password '(.*)'$/ do |username, password|
  visit path_to('login')
  step "I fill in \"username\" with \"#{username}\""
  step "I fill in \"password\" with \"#{password}\""
  step "I press \"login_submit\""
  step "I should be redirected to the home page"
end

And /^(?:|I )should be logged in$/ do
  step "I should see \"You are logged in\""
end

Then /^(?:I )should see the schedule for two payment periods$/ do
  page.should have_content("Schedule")
end