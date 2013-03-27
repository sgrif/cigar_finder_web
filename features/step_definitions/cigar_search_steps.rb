def get_location(location)
  Geocoder.search(location).first
end

Given /^I am in Albuquerque$/ do
  @location = get_location('Albuquerque')
  @location_name = 'Albuquerque'
end

When /^I list stores near me$/ do
  visit nearby_cigar_stores_path(latitude: @location.latitude, longitude: @location.longitude, format: :json)
  @stores = ActiveSupport::JSON.decode(page.source)
end

Then /^"(.*?)" should be closer than "(.*?)"$/ do |closer, farther|
  closer_index = @stores.index { |store| store['name'] == closer }
  farther_index = @stores.index { |store| store['name'] == farther }
  closer_index.should be < farther_index
end

Then /^"(.*?)" should not be listed$/ do |store|
  @stores.should_not include(store)
end

Given /^"([^"]*?)" carries "(.*?)"$/ do |store_name, cigar|
  store = CigarStoreSearch.near(@location).store_named(store_name)
  CigarStock.save_carried(store, cigar)
end

Given /^"(.*?)" in "(.*?)" carries "(.*?)"$/ do |store_name, location, cigar|
  store = CigarStoreSearch.near(get_location(location)).store_named(store_name)
  CigarStock.save_carried(store, cigar)
end

Given /^"([^"]*?)" does not carry "(.*?)"$/ do |store_name, cigar|
  store = CigarStoreSearch.near(@location).store_named(store_name)
  CigarStock.save_not_carried(store, cigar)
end

Given /^"(.*?)" in "(.*?)" does not carry "(.*?)"$/ do |store_name, location, cigar|
  store = CigarStoreSearch.near(get_location(location)).store_named(store_name)
  CigarStock.save_not_carried(store, cigar)
end

When /^I search for "([^"]*?)"$/ do |cigar|
  get cigar_search_results_path(cigar: cigar, latitude: @location.latitude, longitude: @location.longitude, format: :json)
  @search = ActiveSupport::JSON.decode(last_response.body)
end

When /^I search for "(.*?)" in "(.*?)"$/ do |cigar, location|
  visit cigar_search_results_path(cigar: cigar, latitude: get_location(location).latitude, longitude: get_location(location).longitude, format: :json)
  @search = ActiveSupport::JSON.decode(page.source)
end

def assert_answer(store_name, answer)
  @search.find { |result| result.fetch('cigar_store').fetch('name') == store_name }.fetch('carried').should == answer
end

Then /^I should see it is carried by "(.*?)"$/ do |store_name|
  assert_answer(store_name, true)
end

Then /^I should see it is not carried by "(.*?)"$/ do |store_name|
  assert_answer(store_name, false)
end

Then /^I should see no answer for "(.*?)"$/ do |store_name|
  assert_answer(store_name, nil)
end

Given /^somebody has searched for "(.*?)"$/ do |cigar|
  CigarSearchLog.log_search('127.0.0.1', cigar)
end

Given /^somebody else has searched for "(.*?)"$/ do |cigar|
  CigarSearchLog.log_search('67.41.101.230', cigar)
end

Then /^I should see results for the cigar "(.*?)"$/ do |cigar|
  @search.first.fetch('cigar').should == cigar
end
