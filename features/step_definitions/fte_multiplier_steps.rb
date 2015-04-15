And /^I should have fte_multiplier of (.*)$/ do | value|
	user = User.find_by_id(1)
	assert_equal "#{user.fte_multiplier}", value
end