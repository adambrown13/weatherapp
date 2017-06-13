require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

When /^I start a new at this locations "(.*)"$/ do |location|
  stub_request(:post, "https://api.darksky.net/forecast/8c7f074863e3a66f8e8b76c2dfee5ba6/42.3601,-71.0589").
    to_return(:status => 200, :headers => {}, :body => {"currently":{"time":1497249854,"summary":"Clear","precipProbability":0,"temperature":71.83}})
  visit '/new'
  click_button "Address"
end

When /^I enter "(.*)"(?: again)?$/ do |letter|
  fill_in("addr", :with => letter)
  click_button("Address")
end




When /^I try to go to the URL "(.*)"$/ do |url|
  visit url
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end

When /^(?:|I )press "([^\"]*)"(?: within "([^\"]*)")?$/ do |button, selector|
  with_scope(selector) do
    click_button(button)
  end
end

