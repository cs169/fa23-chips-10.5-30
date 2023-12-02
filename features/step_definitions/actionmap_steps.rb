require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))

Given(/^I select "(.*)" on the map$/) do |state|
  visit "/state/#{state}"
end

Then(/^I select "(.*)" county$/) do |county|
  click_on_county(county)
end

Then(/^I should see the list of reps for "(.*)"$/) do |county|
  expect(page).to have_content(representatives_for(county))
end