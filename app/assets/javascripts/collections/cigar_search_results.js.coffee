class CigarFinderWeb.Collections.CigarSearchResults extends Backbone.Collection
  model: CigarFinderWeb.Models.CigarSearchResult
  url: 'cigar_search_results'
  cachedResponses: {}

  initialize: ->
    @on('reset', @cacheCigar)

  cacheCigar: =>
    @cachedResponses[@cigar] ||= _.clone(@models)

  fetchCigar: (cigar_name) =>
    @cigar = cigar_name
    if @cachedResponses[@cigar]?
      @reset(@cachedResponses[@cigar])
    else
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
