json.array! @cigar_stores do |cigar_store|
  json.extract! cigar_store, :id, :name, :latitude, :longitude, :address
end
