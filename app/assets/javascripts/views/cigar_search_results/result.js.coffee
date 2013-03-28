class CigarFinderWeb.Views.CigarSearchResult extends Backbone.View
  template: JST['cigar_search_results/result']
  tagName: 'li'
  className: 'cigar-search-result'
  events:
    'click .js-report-incorrect': 'resultIncorrect'
    'click .js-report-carried': 'resultCarried'
    'click .js-report-not-carried': 'resultNotCarried'

  render: =>
    @$el.html(@template(search_result: @model))
    this

  resultIncorrect: (e) =>
    e.preventDefault()
    @model.reportIncorrect()

  resultCarried: (e) =>
    e.preventDefault()
    @model.reportCarried()

  resultNotCarried: (e) =>
    e.preventDefault()
    @model.reportNotCarried()
