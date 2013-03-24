When /^I visit the home page$/ do
  visit('/')
end

When /^I visit the search page for "(.*?)"$/ do |cigar|
  visit("/#{URI.encode(cigar).gsub('%20', '+')}")
end

When /^I open the search box$/ do
  find('#js-find-a-cigar').click
end

When /^I fill in the search box with "(.*?)"$/ do |text|
  find('.cigar-search-form input[type=search]', visible: true).set(text)
end

Then /^I should see an autocomplete box with the following:$/ do |table|
  table.raw.map(&:first).each do |value|
    find('ul.typeahead').should have_selector("li[data-value='#{value}']", count: 1)
  end
  find('ul.typeahead').should have_selector("li", count: table.raw.count)
end
