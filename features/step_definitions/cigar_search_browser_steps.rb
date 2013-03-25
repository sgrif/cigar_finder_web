When /^I visit the home page$/ do
  visit('/')
end

When /^I visit the search page for "(.*?)"$/ do |cigar|
  visit("/#{URI.encode(cigar).gsub('%20', '+')}")
end

When /^I open the search box$/ do
  find('#js-find-a-cigar').click
end

When /^I open the add cigar form$/ do
  find('#js-add-a-cigar').click
end

When /^I fill in the cigar input with "(.*?)"$/ do |text|
  find('input.js-cigar-name', visible: true).set(text)
end

Then /^I should see an autocomplete box with the following:$/ do |table|
  table.raw.map(&:first).each do |value|
    find('ul.typeahead').should have_selector("li[data-value='#{value}']", count: 1)
  end
  find('ul.typeahead').should have_selector("li", count: table.raw.count)
end

Then /^selected store should be "(.*?)"$/ do |store_name|
  find('#js-new-result-cigar-store-id option', text: store_name).should be_selected
end

Then /^the store list should contain "(.*?)"$/ do |store_name|
  find('#js-new-result-cigar-store-id').should have_selector('option', text: store_name)
end

When /^I report that "(.*?)" carries "(.*?)"$/ do |store_name, cigar|
  visit('/')
  find('#js-add-a-cigar').click
  find('#js-new-result-cigar-store-id', visible: true)
  select(store_name, from: 'js-new-result-cigar-store-id')
  fill_in('js-new-result-cigar', with: cigar)
  page.choose('Carried')
  find('#js-new-result-submit').click
end

Then /^I should be redirected to the search page for "(.*?)"$/ do |cigar_name|
  current_path.should == URI.encode(cigar_name).gsub("%20", "+")
end
