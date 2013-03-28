class CigarFinderWeb.Views.CigarSearchResult extends Backbone.View
  template: JST['cigar_search_results/result']
  tagName: 'li'
  className: 'cigar-search-result'
  events:
    'click #js-report-incorrect': 'resultIncorrect'
    'click #js-report-carried': 'resultCarried'
    'click #js-report-not-carried': 'resultNotCarried'

  render: =>
    @$el.html(@template(search_result: @model))
    this

  updateCarried: (e, carried) =>
    e.preventDefault()
    @model.set('carried', carried)
    @model.save()

  resultIncorrect: (e) => @updateCarried(e, !@model.get('carried'))
  resultCarried: (e) => @updateCarried(e, true)
  resultNotCarried: (e) => @updateCarried(e, false)
