class CigarFinderWeb.Views.CigarSearchResult extends Backbone.View
  tagName: 'li'

  render: ->
    @$el.html(@model.get('name'))
    this
