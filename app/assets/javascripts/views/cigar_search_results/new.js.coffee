class CigarFinderWeb.Views.NewCigarSearchResult extends Backbone.View
  template: JST['cigar_search_results/new']
  tagName: 'form'

  render: =>
    @getNearbyStores()
    @$el.html(@template())
    @$('input.js-cigar-name').typeahead(source: CigarFinderWeb.cigars)
    @nearbyStores.each(@addStore)
    this

  getNearbyStores: =>
    unless @nearbyStores?
      @nearbyStores = CigarFinderWeb.Collections.CigarStores.nearbyStores()
      @nearbyStores.on('add', @addStore)

  addStore: (store) =>
    @$('#js-new-result-cigar-store-id').append(
      "<option value='#{store.get('id')}'>#{store.get('name')}</option>")
