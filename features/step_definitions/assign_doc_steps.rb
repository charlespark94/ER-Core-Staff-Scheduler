Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create(user)
  end
end

Given /(.+) chooses yes on the shift (.+) at availabilities page/ do |e1, e2|
	shift = Shift.find(e2)
	user = User.find_by_first_name(e1)
	newstring = "#{shift.users} 1"
	shift.update_attributes(:users => newstring)
end

Then /I should see the users is (.+)/ do |e2|
	page.should have_content(e2)
end

Then /^(?:|I )should be redirected to the edit page for shift (.+)$/ do |shift|
  visit edit_shift_path(shift)
end

Then /I should see a dropdown menu for (.+)/ do |e1|
	page.should have_content(e1)
end

Then /I select (.+) for Assign Person/ do |e1|
	select(e1, :from => "shift_owner")
end

Then /I should see the owner is (.+)/ do |e2|
	page.should have_content(e2)
end





