Given /the following shifts exist/ do |shifts_table|
  shifts_table.hashes.each do |shift|
    Shift.create(shift)

  end
end

When /^(?:|I )choose "([^"]*)" of shift: (.*)/ do |field, shifts|
  shifts.split(',').each do |shift|
    choose("#{shift}_#{field}")
  end
end

Then /^(?:|I )should see that "([^"]*)" equals (.*)$/ do |header, value|
  table_id = page.all("table#shifts td.#{header}").map(&:text)
  assert_equal table_id.to_s, value
end
