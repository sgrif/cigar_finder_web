class CigarFinderWeb.Collections.CigarStores extends Backbone.Collection
  model: CigarFinderWeb.Models.CigarStore

  @nearbyStores: =>
    nearbyStores = new CigarFinderWeb.Collections.CigarStores
    CigarFinderWeb.Services.LocationLoader.loadLocation (position) =>
      nearbyStores.fetch
        url: 'cigar_stores/nearby'
        data:
          latitude: position.latitude
          longitude: position.longitude
    nearbyStores
