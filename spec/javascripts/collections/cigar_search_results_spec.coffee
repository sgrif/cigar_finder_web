describe "CigarFinderWeb.Collections.CigarSearchResults", ->
  [collection] = []

  beforeEach =>
    collection = new CigarFinderWeb.Collections.CigarSearchResults()
    spyOn(collection, 'fetch')

  describe "fetching user position", =>
    it "has a timeout of 10 seconds", =>
      spyOn(navigator.geolocation, 'getCurrentPosition')
      collection.fetchCigar('Anything')
      expect(navigator.geolocation.getCurrentPosition).toHaveBeenCalledWith(
        jasmine.any(Function),
        jasmine.any(Function),
        {timeout: 10000}
      )

    describe "geolocation supported", =>
      it "performs an API call with user location", =>
        spyOn(navigator.geolocation, 'getCurrentPosition').andCallFake (success) =>
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
        spyOn(navigator.geolocation, 'getCurrentPosition').andCallFake (s, error) =>
          error()
        collection.fetchCigar('Liga Privada Undercrown')
        expect(collection.fetch).toHaveBeenCalledWith(data: {cigar: 'Liga Privada Undercrown'})
