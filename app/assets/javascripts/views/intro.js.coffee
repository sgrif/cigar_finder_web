class CigarFinderWeb.Views.Intro extends Backbone.View
  template: JST['intro']
  events:
    'click #js-find-a-cigar': 'renderFind'
    'submit #js-intro-find-form': 'submitFind'

  render: ->
    @$el.html(@template())
    @$('#js-intro-buttons').fadeIn()
    @$('#js-intro-find-cigar-name').typeahead(source: CigarFinderWeb.cigars)
    this

  renderFind: ->
    @$('.intro-step:visible').fadeOut
      complete: => @$('#js-intro-find-form').fadeIn()

  submitFind: (e) ->
    e.preventDefault()
    cigar_name = @$('#js-intro-find-cigar-name').val()
    Backbone.history.navigate(encodePlus(cigar_name), trigger: true) if cigar_name
