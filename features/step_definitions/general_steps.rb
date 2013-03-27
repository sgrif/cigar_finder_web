When /^pending$/ do
  pending
end

When /^I click on "(.*?)"$/ do |link|
  find('a', text: link, visible: true).click
end
