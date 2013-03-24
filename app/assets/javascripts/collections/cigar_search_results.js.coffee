class CigarFinderWeb.Collections.CigarSearchResults extends Backbone.Collection
  cachedResponses = {}

  model: CigarFinderWeb.Models.CigarSearchResult
  url: 'cigar_search_results'

  initialize: =>
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
    CigarFinderWeb.Services.LocationLoader.loadLocation (position) =>
      @fetch data:
        cigar: cigar_name
        latitude: position.latitude
        longitude: position.longitude
