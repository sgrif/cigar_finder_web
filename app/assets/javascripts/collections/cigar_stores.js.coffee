class CigarFinderWeb.Collections.CigarStores extends Backbone.Collection
  model: CigarFinderWeb.Models.CigarStore

  @near: (location) =>
    nearbyStores = new CigarFinderWeb.Collections.CigarStores
    CigarFinderWeb.Services.LocationLoader.loadLocation location, (position) =>
      nearbyStores.fetch
        url: '/cigar_stores/nearby'
        data:
          latitude: position.latitude
          longitude: position.longitude
    nearbyStores
