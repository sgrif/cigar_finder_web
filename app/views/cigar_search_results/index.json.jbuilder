json.cigar_search_results @search_results do |search_result|
  json.cigar_store search_result.store, :id, :name, :latitude, :longitude
  json.cigar search_result.cigar
  if search_result.carried == CigarSearch::NoAnswer
    json.carried nil
  else
    json.carried search_result.carried
  end
end
