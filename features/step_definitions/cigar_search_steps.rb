def get_location(location)
  Geocoder.search(location).first
end

Given /^I am in Albuquerque$/ do
  @location = get_location('Albuquerque')
end

When /^I list stores near me$/ do
  @stores = CigarStoreSearch.near(@location).results.collect(&:name)
end

Then /^"(.*?)" should be closer than "(.*?)"$/ do |store, other_store|
  @stores.index(store).should be < @stores.index(other_store)
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
  stores = CigarStoreSearch.near(@location).results
  @search = CigarSearch.new(cigar, stores)
end

When /^I search for "(.*?)" in "(.*?)"$/ do |cigar, location|
  stores = CigarStoreSearch.near(get_location(location)).results
  @search = CigarSearch.new(cigar, stores)
end

Then /^I should see it is carried by "(.*?)"$/ do |store_name|
  @search.results.find { |result| result.store.name == store_name }.carried.should == true
end

Then /^I should see it is not carried by "(.*?)"$/ do |store_name|
  @search.results.find { |result| result.store.name == store_name }.carried.should == false
end

Then /^I should see no answer for "(.*?)"$/ do |store_name|
  @search.results.find { |result| result.store.name == store_name }.carried.should == CigarSearch::NoAnswer
end
