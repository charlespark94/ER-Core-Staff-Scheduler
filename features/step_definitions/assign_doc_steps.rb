Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create(user)
  end
end

Given /(.+) chooses yes on the shift (.+) at availabilities page/ do |e1, e2|
	shift = Shift.find(e2)
	user = User.find_by_id(1)

  @availability = Availability.where(user_id: user.id, shift_id: shift.id).first
  if @availability.nil?
    @availability = shift.availabilities.build(:user_id => user.id)
  end
  @availability.update_attributes(:availability => 2)
  if !@availability.save
    flash[:notice] = "Something bad happened"
  end
	# newstring = "#{shift.users} 1"
	# shift.update_attributes(:users => newstring)
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

Then /^I should see that "([^"]*)" has (.+) hours assigned$/ do |name, hour|
  user = User.find_by_first_name(name)
  shift = Shift.find_by_owner(user.first_name)
  if !shift.nil?
  	assert_equal ((shift.shiftend - shift.shiftstart)/(60*60)).to_i.to_s, hour
  else
  	assert_equal 0.to_s, hour
  end
end





