class CigarFinderWeb.Collections.CigarSearchResults extends Backbone.Collection
  model: CigarFinderWeb.Models.CigarSearchResult
  url: 'cigar_search_results'

  fetchCigar: (cigar_name) =>
    data = {cigar: cigar_name}
    onLoad = =>
      @fetch(data: data)
    success = =>
      data.latitude = @position.latitude
      data.longitude = @position.longitude
      onLoad()
    @loadLocation(success, onLoad)

  loadLocation: (success = (->), error = (->)) =>
    return success() if @position?
    return error() unless navigator.geolocation?
    onSuccess = (position) =>
      @position = position.coords
      success()
    navigator.geolocation.getCurrentPosition(onSuccess, error, {timeout: 10000})
