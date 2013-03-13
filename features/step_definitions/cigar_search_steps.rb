class Location < Struct.new(:latitude, :longitude); end

Given /^I am in Albuquerque$/ do
  @location = Location.new(35.12384, -106.586094)
end

When /^I list stores near me$/ do
  @stores = CigarStoreSearch.stores_near(@location)
end

Then /^"(.*?)" should be closer than "(.*?)"$/ do |store, other_store|
  @stores.index(store).should be < @stores.index(other_store)
end
