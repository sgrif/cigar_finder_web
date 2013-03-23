class CigarFinderWeb.Views.CigarSearchResultsIndex extends Backbone.View
  template: JST['cigar_search_results/index']
  tagName: 'ul'
  className: 'unstyled results-list'

  initialize: =>
    @collection.on('reset', @render)

  render: =>
    @$el.html(@template())

    for selector, carried_value of {'carried': true, 'not-carried': false, 'no-answer': null}
      filtered = @collection.where(carried: carried_value)
      $list_item = @$("#js-results-list-#{selector}")
      if filtered.length is 0
        $list_item.remove()
      else
        filtered.forEach (result) => @addResultTo(result, $list_item.find('ul'))
    this

  addResultTo: (result, $element) =>
    view = new CigarFinderWeb.Views.CigarSearchResult(model: result.get('cigar_store'))
    $element.append(view.render().el)
