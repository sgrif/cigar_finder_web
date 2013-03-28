class CigarFinderWeb.Views.CigarSearchResult extends Backbone.View
  template: JST['cigar_search_results/result']
  tagName: 'li'

  render: =>
    @$el.html(@template(search_result: @model))
    this
