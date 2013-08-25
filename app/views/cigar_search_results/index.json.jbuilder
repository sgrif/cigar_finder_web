json.array! @search_results do |search_result|
  json.partial! partial: search_result, formats: [:json]
end
