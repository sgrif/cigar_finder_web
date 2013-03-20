describe 'CigarFinderWeb.Views.CigarSearch', ->
  [collection, view, $el] = []

  beforeEach =>
    spyOn(navigator.geolocation, 'getCurrentPosition').andCallFake (callback) ->
      callback(coords: {latitude: 1, longitude: -1})
    collection = new Backbone.Collection()
    view = new CigarFinderWeb.Views.CigarSearch(collection: collection)
    $el = $(view.render().el)

  describe 'render', =>
    it 'loads the users location', =>
      expect(navigator.geolocation.getCurrentPosition).toHaveBeenCalled()

    it 'displays a search form', =>
      expect($el).toContain('form#new-search')
      form = $el.find('form#new-search')
      expect(form).toContain('input#new-search-cigar')
      expect(form).toContain('input[type=submit][value="Find it"]')

  describe 'performing a search', =>
    beforeEach =>
      spyOn(collection, 'fetch')

    performSearch = (cigar) =>
      $el.find('#new-search-cigar').val(cigar)
      $el.find('#new-search').trigger('submit')

    it 'queries the api', =>
      performSearch('Tatuaje 7th Reserva')
      expect(collection.fetch).toHaveBeenCalledWith
        data:
          cigar: 'Tatuaje 7th Reserva'
          latitude: 1
          longitude: -1

    it 'resets the form', =>
      performSearch('Anything')
      expect($el.find('#new-search-cigar').val()).toBe('')

    it 'displays the cigar name', =>
      performSearch('Illusione MK4')
      expect($el.find('#js-cigar-name').html()).toBe('Illusione MK4')
