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

Given /^"(.*?)" carries "(.*?)"$/ do |store_name, cigar_name|
  CigarStock.save_carried(store_name, cigar_name)
end

When /^I search for "(.*?)" in Albuquerque$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see it is carried by "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
