class CigarFinderWeb.Models.CigarSearchResult extends Backbone.Model
  url: '/cigar_search_results'

  initialize: ->
    if @get('cigar_store')
      @set('cigar_store', new CigarFinderWeb.Models.CigarStore(@get('cigar_store')))
      @set('cigar_store_id', @get('cigar_store').get('id'))
