Given /^'(.*)' has been added to the database$/ do |username|
  visit path_to('signup')
  step "I fill in \"user_first_name\" with \"#{username}\""
  step "I fill in \"user_last_name\" with \"#{username}\""
  step "I fill in \"user_username\" with \"#{username}\""
  step "I fill in \"user_email\" with \"example@example.com\""
  step "I fill in \"user_password\" with \"#{username}\""
  step "I fill in \"user_password_confirmation\" with \"#{username}\""
  step "I press \"Sign Up\""
  User.find_by_first_name("#{username}").update_attributes(:fte => 1, :fte_multiplier => 1)
end

Given /^(?:|I )am logged in as '(.*)' with password '(.*)'$/ do |username, password|
  visit path_to('login')
  step "I fill in \"username\" with \"#{username}\""
  step "I fill in \"password\" with \"#{password}\""
  step "I press \"Log In\""
  step "I should be redirected to the home page"
end

And /^(?:|I )should be logged in$/ do
  step "I should see \"You are logged in\""
end

Then /^(?:I )should see the schedule for two payment periods$/ do
  page.should have_css("iframe")
end