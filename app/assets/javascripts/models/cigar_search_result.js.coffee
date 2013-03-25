class CigarFinderWeb.Models.CigarSearchResult extends Backbone.Model
  url: 'cigar_search_results'

  initialize: ->
    @set('cigar_store', new CigarFinderWeb.Models.CigarStore(@get('cigar_store')))
