def encode_elements(*args)
  encoded = args.reject(&:nil?).map { |el| URI.encode(el).gsub('%20', '+') }
  "/#{encoded.join("/")}"
end

def search_for_cigar(cigar)
  visit(encode_elements(cigar, @location_name))
  find('#js-cigar-name', visible: true, text: cigar)
end

When /^I visit the home page$/ do
  visit('/')
end

When /^I visit the search page for "(.*?)"$/ do |cigar|
  search_for_cigar(cigar)
end

When /^I fill in the cigar input with "(.*?)"$/ do |text|
  find('input.js-cigar-name', visible: true).set(text)
end

Then /^I should see an autocomplete box with the following:$/ do |table|
  table.raw.map(&:first).each do |value|
    find('#container ul.typeahead', visible: false).should have_selector("li[data-value='#{value}']", count: 1, visible: false)
  end
  find('#container ul.typeahead', visible: false).should have_selector("li", count: table.raw.count, visible: false)
end

Then /^the store list should contain "(.*?)"$/ do |store_name|
  find('#js-new-result-cigar-store-id').should have_selector('option', text: store_name)
end

def report_cigar(store_name, cigar, selector)
  search_for_cigar(cigar)
  find('li.cigar-search-result', text: store_name, visible: true).
    find(selector).trigger('click')
end

When /^I report that "(.*?)" carries "(.*?)"$/ do |store_name, cigar|
  report_cigar(store_name, cigar, '.js-report-carried')
end

When /^I report that "(.*?)" does not carry "(.*?)"$/ do |store_name, cigar|
  report_cigar(store_name, cigar, '.js-report-not-carried')
end

When /^I report that the data for "(.*?)" is incorrect$/ do |store_name|
  find('li.cigar-search-result', text: store_name, visible: true).
    find('.js-report-incorrect').trigger('click')
end

Then /^the page should show it is carried by "(.*?)"$/ do |store_name|
  find('#js-results-list-carried', visible: true).should have_selector('li', text: store_name)
end

Then /^the page should show it is not carried by "(.*?)"$/ do |store_name|
  find('#js-results-list-not-carried', visible: true).should have_selector('li', text: store_name)
end
