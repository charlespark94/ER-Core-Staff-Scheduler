#require 'uri'
#require 'cgi'
#require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
#require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

#module WithinHelpers
#  def with_scope(locator)
#    locator ? within(*selector_for(locator)) { yield } : yield
#  end
#end
#World(WithinHelpers)

Given /that I am signed in/ do
end



When /I am on the "(.+)" page/ do |page_name|
  visit path_to(page_name)
end

And /I am an admin user/ do
end


Then /I should see a (.+) labeled (.+)/ do |e1, e2|
	if e2 =~ /ShiftStart/ or e2 =~ /ShiftEnd/
		assert e1 =~ /datetime_select/
	elsif e2 =~ /Save/
		assert e1 =~ /submit_tag/
	end
end

Then /I fill in time (.+) with (.+)-(.+)-(.+)-(.+)-(.+)/ do |field ,year, month, day, hour, minute|
  select(year,   :from => "shift_#{field}_1i")
  select(month,  :from => "shift_#{field}_2i")
  select(day,    :from => "shift_#{field}_3i")
  select(hour,   :from => "shift_#{field}_4i")
  select(minute, :from => "shift_#{field}_5i")
end

And /I press "(.+)"/ do |button|
	click_button(button)
end

Then /I should be redirected to the "(.+)" page/ do |page|
	visit path_to(page)
end

And /I should see one time (.+) is "(.+)"/ do |field, time|
	page should have_content(time)
end

And /I should see one (.*) is (.*)/ do |e1, e2|
	page.should have_content(e2)
end

