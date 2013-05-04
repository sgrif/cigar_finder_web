def get_location(location)
  Geocoder.search(location).first
end

Given /^I am in Albuquerque$/ do
  @location = get_location('Albuquerque')
  @location_name = 'Albuquerque'
end

When /^I list stores near me$/ do
  get nearby_cigar_stores_path(latitude: @location.latitude, longitude: @location.longitude,
                               format: :json)
  @stores = ActiveSupport::JSON.decode(last_response.body)
end

Then /^"(.*?)" should be closer than "(.*?)"$/ do |store_name, other_store_name|
  store = @stores.find { |data| data['name'] == store_name }
  other_store = @stores.find { |data| data['name'] == other_store_name }
  @stores.index(store).should be < @stores.index(other_store)
end

Then /^"(.*?)" should not be listed$/ do |store|
  @stores.should_not include(store)
end

Given /^"([^"]*?)" carries "(.*?)"$/ do |store_name, cigar|
  store = CigarStoreSearch.near(@location).store_named(store_name)
  post report_carried_cigar_search_results_path(cigar_store_id: store.id, cigar: cigar,
                                               format: :json)
end

Given /^"(.*?)" in "(.*?)" carries "(.*?)"$/ do |store_name, location, cigar|
  store = CigarStoreSearch.near(get_location(location)).store_named(store_name)
  post report_carried_cigar_search_results_path(cigar_store_id: store.id, cigar: cigar,
                                               format: :json)
end

Given /^"([^"]*?)" does not carry "(.*?)"$/ do |store_name, cigar|
  store = CigarStoreSearch.near(@location).store_named(store_name)
  post report_not_carried_cigar_search_results_path(cigar_store_id: store.id, cigar: cigar,
                                                   format: :json)
end

Given /^"(.*?)" in "(.*?)" does not carry "(.*?)"$/ do |store_name, location, cigar|
  store = CigarStoreSearch.near(get_location(location)).store_named(store_name)
  post report_not_carried_cigar_search_results_path(cigar_store_id: store.id, cigar: cigar,
                                                   format: :json)
end

Given /^"(.*?)" was reported to carry "(.*?)" yesterday/ do |store_name, cigar|
  store = CigarStoreSearch.near(@location).store_named(store_name)
  stock = CigarStock.save_carried(store, cigar)
  stock.updated_at = Date.yesterday
  stock.created_at = Date.yesterday
  stock.save
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

Given /^(\d+) people have searched for "(.*?)"$/ do |count, cigar|
  count.to_i.times do |x|
    CigarSearchLog.log_search("127.0.0.#{x}", cigar)
  end
end

Then /^I should see results for the cigar "(.*?)"$/ do |cigar|
  @search.first.fetch('cigar').should == cigar
end

When /^I ask what information we need for "(.*?)"$/ do |store_name|
  store = CigarStoreSearch.near(@location).store_named(store_name)
  get missing_information_cigar_store_path(store, format: :json)
end

Then /^the cigar I am given should be "(.*?)"$/ do |response|
  ActiveSupport::JSON.decode(last_response.body).should == { 'cigar' => response }
end
