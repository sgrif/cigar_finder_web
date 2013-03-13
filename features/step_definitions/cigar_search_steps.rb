class Location < Struct.new(:latitude, :longitude); end

def albuquerque
  Location.new(35.12384, -106.586094)
end

Given /^I am in Albuquerque$/ do
  @location = albuquerque
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

When /^I search for "(.*?)" in Albuquerque$/ do |cigar|
  @search = CigarSearch.new(cigar, albuquerque)
end

Then /^I should see it is carried by "(.*?)"$/ do |store|
  @search.results.find { |result| result.store == store }.carried.should == true
end
