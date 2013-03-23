class CigarFinderWeb.Models.CigarSearchResult extends Backbone.Model
  initialize: ->
    @set('cigar_store', new CigarFinderWeb.Models.CigarStore(@get('cigar_store')))
