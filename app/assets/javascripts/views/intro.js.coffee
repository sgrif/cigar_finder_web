class CigarFinderWeb.Views.Intro extends Backbone.View
  template: JST['intro']
  className: 'hero-unit text-center'
  events:
    'click #js-find-a-cigar': 'renderFind'
    'click #js-add-a-cigar': 'visitAdd'
    'submit #js-intro-find-form': 'submitFind'

  initialize: (options = {}) ->
    @searchForm = new CigarFinderWeb.Views.CigarSearchForm()
    @addForm = new CigarFinderWeb.Views.NewCigarSearchResult(location: options.location)

  render: ->
    @$el.html(@template())
    this

  fadeTo: (view) ->
    $visible = @$('.intro-step:visible')
    if $visible.length
      $visible.fadeOut =>
        view.$el.fadeIn()
    else
      view.$el.show()

  visitAdd: ->
    Backbone.history.navigate('add-a-cigar', trigger: true)

  renderButtons: =>
    @fadeTo($el: @$('#js-intro-buttons'))

  renderAdd: =>
    @assign(@addForm, '#js-intro-add-form')
    @fadeTo(@addForm)

  renderFind: ->
    @assign(@searchForm, '#js-intro-find-form')
    @fadeTo(@searchForm)

  submitFind: (e) ->
    e.preventDefault()
    cigar_name = @$('#js-intro-find-cigar-name').val()
    Backbone.history.navigate(encodePlus(cigar_name), trigger: true) if cigar_name
