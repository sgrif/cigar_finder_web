json.array! @search_results do |search_result|
  json.cigar_store search_result.cigar_store, :id, :name, :latitude, :longitude, :address
  json.extract! search_result, :cigar, :carried, :updated_at
end
