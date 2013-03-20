class CigarFinderWeb.Views.CigarSearchResult extends Backbone.View
  template: JST['cigar_search_results/result']

  render: ->
    @$el.html(@template(result: @model))
    this
