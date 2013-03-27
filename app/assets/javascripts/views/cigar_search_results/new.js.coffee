class CigarFinderWeb.Views.NewCigarSearchResult extends Backbone.View
  template: JST['cigar_search_results/new']
  tagName: 'form'

  events:
    'submit': 'saveResult'

  initialize: (options = {}) ->
    @location = options.location

  render: =>
    @getNearbyStores()
    @$el.html(@template())
    @$('input.js-cigar-name').typeahead(source: CigarFinderWeb.cigars)
    @nearbyStores.each(@addStore)
    this

  getNearbyStores: =>
    unless @nearbyStores?
      @nearbyStores = CigarFinderWeb.Collections.CigarStores.near(@location)
      @nearbyStores.on('add', @addStore)

  addStore: (store) =>
    @$('#js-new-result-cigar-store-id').append(
      "<option value='#{store.get('id')}'>#{store.get('name')}</option>")

  saveResult: (e) =>
    e.preventDefault()
    @model = new CigarFinderWeb.Models.CigarSearchResult
      cigar_store_id: @$('#js-new-result-cigar-store-id').val()
      cigar: @$('#js-new-result-cigar').val()
      carried: @$('.js-cigar-carried:checked').val()
    @model.save()
    Backbone.history.navigate(@searchUri(), trigger: true)

  searchUri: =>
    uri = encodePlus(@model.get('cigar'))
    uri += "/#{encodePlus(@location)}" if @location?
    uri
