class CigarFinderWeb.Collections.CigarSearchResults extends Backbone.Collection
  cachedResponses = {}

  model: CigarFinderWeb.Models.CigarSearchResult
  url: '/cigar_search_results'

  @clearCache: =>
    cachedResponses = {}

  initialize: =>
    @on('reset', @cacheCigar)

  cacheCigar: =>
    cachedResponses[@cigar] ||= {}
    cachedResponses[@cigar][@location] ||= _.clone(@models)

  hasCachedCigar: (cigar, location) =>
    cachedResponses[cigar]? and cachedResponses[cigar][location]?

  loadCachedCigar: (cigar, location) =>
    @reset(cachedResponses[cigar][location])

  fetchCigar: (cigar_name, location) =>
    [@cigar, @location] = [cigar_name, location]
    if @hasCachedCigar(cigar_name, location)
      @loadCachedCigar(cigar_name, location)
    else
      @loadCigar(cigar_name, location)

  loadCigar: (cigar_name, location) =>
    CigarFinderWeb.Services.LocationLoader.loadLocation location, (position) =>
      @fetch
        data:
          cigar: cigar_name
          latitude: position.latitude
          longitude: position.longitude
        reset: true
