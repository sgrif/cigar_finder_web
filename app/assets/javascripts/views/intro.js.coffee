class CigarFinderWeb.Views.Intro extends Backbone.View
  template: JST['intro']
  className: 'hero-unit text-center'
  events:
    'click #js-find-a-cigar': 'renderFind'
    'click #js-add-a-cigar': 'renderAdd'
    'submit #js-intro-find-form': 'submitFind'

  render: ->
    @$el.html(@template())
    @addCigarView = new CigarFinderWeb.Views.NewCigarSearchResult(className: 'intro-step')
    @$el.append(@addCigarView.render().el)
    @$('#js-intro-buttons').show()
    @$('#js-intro-find-cigar-name').typeahead(source: CigarFinderWeb.cigars)
    this

  fadeTo: ($element) ->
    @$('.intro-step:visible').fadeOut =>
      $element.fadeIn()

  renderFind: ->
    @fadeTo(@$('#js-intro-find-form'))

  renderAdd: ->
    @fadeTo(@addCigarView.$el)

  submitFind: (e) ->
    e.preventDefault()
    cigar_name = @$('#js-intro-find-cigar-name').val()
    Backbone.history.navigate(encodePlus(cigar_name), trigger: true) if cigar_name
