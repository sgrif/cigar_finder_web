describe "CigarFinderWeb.Collections.CigarSearchResults", ->
  [collection] = []

  beforeEach =>
    spyOn(navigator.geolocation, 'getCurrentPosition')
    collection = new CigarFinderWeb.Collections.CigarSearchResults()
    spyOn(collection, 'fetch')

  describe "fetching user position", =>
    it "has a timeout of 5 seconds", =>
      collection.fetchCigar('Anything')
      expect(navigator.geolocation.getCurrentPosition).toHaveBeenCalledWith(
        jasmine.any(Function),
        jasmine.any(Function),
        {timeout: 5000}
      )

    describe "geolocation supported", =>
      it "performs an API call with user location", =>
        navigator.geolocation.getCurrentPosition.andCallFake (success) =>
          success(coords: {latitude: 1, longitude: -1})
        collection.fetchCigar('Tatuaje 7th Reserva')

        expect(collection.fetch).toHaveBeenCalledWith data:
          cigar: 'Tatuaje 7th Reserva'
          latitude: 1
          longitude: -1

    describe "geolocation not supported", =>
      oldNavigator = null

      beforeEach =>
        oldNavigator = window.navigator
        window.navigator = {geolocation: null}

      afterEach =>
        window.navigator = oldNavigator

      it "performs an API call without user location", =>
        collection.fetchCigar('Illusione MK4')
        expect(collection.fetch).toHaveBeenCalledWith(data: {cigar: 'Illusione MK4'})

    describe "geolocation times out", =>
      it "performs an API call without user location", =>
        navigator.geolocation.getCurrentPosition.andCallFake (s, error) =>
          error()
        collection.fetchCigar('Liga Privada Undercrown')
        expect(collection.fetch).toHaveBeenCalledWith(data: {cigar: 'Liga Privada Undercrown'})

  describe "fetching a cigar", =>
    beforeEach =>
      spyOn(collection, "sync").andCallFake () =>
        collection.reset([{cigar_store: "Monte's", cigar: collection.cigar, carried: true}])
      collection.fetch.andCallThrough()
      navigator.geolocation.getCurrentPosition.andCallFake (success, error) =>
        error()

    it "only calls fetch once per cigar", =>
      collection.fetchCigar('Tatuaje 7th Reserva')
      expect(collection.fetch).toHaveBeenCalledWith(data: {cigar: 'Tatuaje 7th Reserva'})
      collection.fetchCigar('Tatuaje 7th Reserva')
      expect(collection.fetch.callCount).toBe(1)

    it "caches a copy of its models", =>
      collection.fetchCigar('Tatuaje 7th Reserva')
      collection.fetchCigar('Illusione MK4')
      collection.fetchCigar('Tatuaje 7th Reserva')
      expect(collection.at(0)).toBeDefined()
      expect(collection.at(0).get('cigar')).toBe('Tatuaje 7th Reserva')
