Given /^I am in "([^"]*)"$/ do |location|
  @location = Geocoder.search(location)
end

When /^I list stores near me$/ do
  @stores = CigarStoreSearch.stores_near(@location)
end
