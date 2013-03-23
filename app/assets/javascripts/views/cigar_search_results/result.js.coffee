class CigarFinderWeb.Views.CigarSearchResult extends Backbone.View
  tagName: 'li'

  render: ->
    @$el.html(@model.get('cigar_store').get('name'))
    this
