class CigarFinderWeb.Views.NewCigarSearchResult extends Backbone.View
  template: JST['cigar_search_results/new']
  tagName: 'form'

  render: =>
    nearbyStores = CigarFinderWeb.Collections.CigarStores.nearbyStores()
    @$el.html(@template(cigar_stores: nearbyStores))
    this
