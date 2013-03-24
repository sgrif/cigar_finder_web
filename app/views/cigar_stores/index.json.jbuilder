json.array! @cigar_stores do |cigar_store|
  json.extract! cigar_store, :name, :latitude, :longitude, :address
end
