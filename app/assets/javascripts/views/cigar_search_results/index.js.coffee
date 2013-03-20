class CigarFinderWeb.Views.CigarSearchResultsIndex extends Backbone.View
  tagName: 'dl'
  className: 'dl-horizontal'

  render: =>
    @$el.html('')
    @collection.each(@addResult)
    this

  addResult: (result) =>
    view = new CigarFinderWeb.Views.CigarSearchResult(model: result)
    @$el.append(view.render().el)
