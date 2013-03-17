class CigarFinderWeb.Models.CigarSearchResult extends Backbone.Model
  carriedDescription: ->
    switch @get('carried')
      when true then "Yes"
      when false then "No"
      else "I don't know"
