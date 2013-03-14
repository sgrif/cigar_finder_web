json.cigar @cigar
json.results @search_results do |search_result|
  json.store search_result.store.name
  json.latitude search_result.store.latitude
  json.longitude search_result.store.longitude
  if search_result.carried == CigarSearch::NoAnswer
    json.carried nil
  else
    json.carried search_result.carried
  end
end
