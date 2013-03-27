describe "CigarFinderWeb.Collections.CigarSearchResults", ->
  [collection] = []

  beforeEach =>
    CigarFinderWeb.Collections.CigarSearchResults.clearCache()
    spyOn(CigarFinderWeb.Services.LocationLoader, 'loadLocation').andCallFake(
      (location, callback) ->
        if location?
          callback(latitude: 2, longitude: -2)
        else
          callback(latitude: 1, longitude: -1)
    )
    collection = new CigarFinderWeb.Collections.CigarSearchResults()
    spyOn(collection, 'fetch')

  describe "fetching a cigar", =>
    beforeEach =>
      spyOn(Backbone, 'ajax').andCallFake (options) =>
        options.success([
          cigar_store:
            name: "Monte's"
            latitude: options.data.latitude
            longitude: options.data.longitude
          cigar: options.data.cigar
        ])
      collection.fetch.andCallThrough()

    it "performs an API call with user location", =>
      collection.fetchCigar('Tatuaje 7th Reserva')
      expect(collection.fetch).toHaveBeenCalledWith
        data:
          cigar: 'Tatuaje 7th Reserva'
          latitude: 1
          longitude: -1
        reset: true

    it "only calls fetch once per cigar", =>
      collection.fetchCigar('Tatuaje 7th Reserva')
      collection.fetchCigar('Tatuaje 7th Reserva')
      expect(collection.fetch.callCount).toBe(1)

    it "caches a copy of its models", =>
      collection.fetchCigar('Tatuaje 7th Reserva')
      collection.fetchCigar('Illusione MK4')
      collection.fetchCigar('Tatuaje 7th Reserva')
      expect(collection.at(0)).toBeDefined()
      expect(collection.at(0).get('cigar')).toBe('Tatuaje 7th Reserva')

    it "searches for a specific location", =>
      collection.fetchCigar('Tatuaje 7th Reserva', 'Albuquerque')
      expect(collection.fetch).toHaveBeenCalledWith
        data:
          cigar: 'Tatuaje 7th Reserva'
          latitude: 2
          longitude: -2
        reset: true

    it "caches results specific to the requested location", =>
      collection.fetchCigar('Tatuaje 7th Reserva')
      expect(collection.at(0).get('cigar_store').get('longitude')).toBe(-1)
      collection.fetchCigar('Tatuaje 7th Reserva', 'Albuquerque')
      expect(collection.at(0).get('cigar_store').get('longitude')).toBe(-2)
      expect(collection.fetch.callCount).toBe(2)
      collection.fetchCigar('Tatuaje 7th Reserva')
      expect(collection.at(0).get('cigar_store').get('longitude')).toBe(-1)
      expect(collection.fetch.callCount).toBe(2)
      collection.fetchCigar('Tatuaje 7th Reserva', 'Albuquerque')
      expect(collection.at(0).get('cigar_store').get('longitude')).toBe(-2)
      expect(collection.fetch.callCount).toBe(2)
