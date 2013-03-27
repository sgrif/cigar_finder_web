class CigarFinderWeb.Views.Intro extends Backbone.View
  template: JST['intro']
  className: 'hero-unit text-center'
  events:
    'click #js-find-a-cigar': 'renderFind'
    'click #js-add-a-cigar': 'renderAdd'
    'submit #js-intro-find-form': 'submitFind'

  initialize: ->
    @searchForm = new CigarFinderWeb.Views.CigarSearchForm()

  render: ->
    @$el.html(@template())
    @addCigarView = new CigarFinderWeb.Views.NewCigarSearchResult(className: 'intro-step')
    @$el.append(@addCigarView.render().el)
    @$('#js-intro-buttons').show()
    @assign(@searchForm, '#js-intro-find-form')
    this

  fadeTo: (view) ->
    @$('.intro-step:visible').fadeOut =>
      view.$el.fadeIn()

  renderFind: ->
    @fadeTo(@searchForm)

  renderAdd: ->
    @fadeTo(@addCigarView)

  submitFind: (e) ->
    e.preventDefault()
    cigar_name = @$('#js-intro-find-cigar-name').val()
    Backbone.history.navigate(encodePlus(cigar_name), trigger: true) if cigar_name
