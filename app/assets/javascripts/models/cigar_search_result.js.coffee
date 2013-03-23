class CigarFinderWeb.Models.CigarSearchResult extends Backbone.Model
  initialize: ->
    @set('cigar_store', new CigarFinderWeb.Models.CigarStore(@get('cigar_store')))

  carriedDescription: ->
    switch @get('carried')
      when true then "Yes"
      when false then "No"
      else "I don't know"
