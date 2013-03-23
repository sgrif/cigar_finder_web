class CigarFinderWeb.Collections.CigarSearchResults extends Backbone.Collection
  cachedResponses = {}

  model: CigarFinderWeb.Models.CigarSearchResult
  url: 'cigar_search_results'

  initialize: ->
    @loadLocation()
    @on('reset', @cacheCigar)

  cacheCigar: =>
    cachedResponses[@cigar] ||= _.clone(@models)

  hasCachedCigar: (cigar) =>
    cachedResponses[cigar]?

  loadCachedCigar: (cigar) =>
    @reset(cachedResponses[cigar])

  fetchCigar: (cigar_name) =>
    @cigar = cigar_name
    if @hasCachedCigar(cigar_name)
      @loadCachedCigar(cigar_name)
    else
      @loadCigar(cigar_name)

  loadCigar: (cigar_name) =>
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
