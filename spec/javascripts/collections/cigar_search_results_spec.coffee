describe "CigarFinderWeb.Collections.CigarSearchResults", ->
  [collection] = []

  beforeEach =>
    spyOn(CigarFinderWeb.Services.LocationLoader, 'loadLocation').andCallFake (callback) ->
      callback(latitude: 1, longitude: -1)
    collection = new CigarFinderWeb.Collections.CigarSearchResults()
    spyOn(collection, 'fetch')

  describe "fetching user position", =>
    it "performs an API call with user location", =>
      collection.fetchCigar('Tatuaje 7th Reserva')
      expect(collection.fetch).toHaveBeenCalledWith
        data:
          cigar: 'Tatuaje 7th Reserva'
          latitude: 1
          longitude: -1
        reset: true

  describe "fetching a cigar", =>
    beforeEach =>
      spyOn(collection, "sync").andCallFake () =>
        collection.reset([{cigar_store: "Monte's", cigar: collection.cigar, carried: true}])
      collection.fetch.andCallThrough()

    it "only calls fetch once per cigar", =>
      collection.fetchCigar('Tatuaje 7th Reserva')
      expect(collection.fetch).toHaveBeenCalledWith
        data:
          cigar: 'Tatuaje 7th Reserva'
          latitude: 1
          longitude: -1
        reset: true
      collection.fetchCigar('Tatuaje 7th Reserva')
      expect(collection.fetch.callCount).toBe(1)

    it "caches a copy of its models", =>
      collection.fetchCigar('Tatuaje 7th Reserva')
      collection.fetchCigar('Illusione MK4')
      collection.fetchCigar('Tatuaje 7th Reserva')
      expect(collection.at(0)).toBeDefined()
      expect(collection.at(0).get('cigar')).toBe('Tatuaje 7th Reserva')
