describe 'CigarFinderWeb.Views.CigarSearch', ->
  [collection, view, $el] = []

  renderView = =>
    collection = new Backbone.Collection()
    view = new CigarFinderWeb.Views.CigarSearch(collection: collection)
    $el = $(view.render().el)

  beforeEach =>
    spyOn(navigator.geolocation, 'getCurrentPosition').andCallFake (callback) ->
      callback(coords: {latitude: 1, longitude: -1})
    renderView()

  describe 'render', =>
    it 'loads the users location', =>
      expect(navigator.geolocation.getCurrentPosition).toHaveBeenCalled()

    it 'displays a search form', =>
      expect($el).toContain('form#new-search')
      form = $el.find('form#new-search')
      expect(form).toContain('input#new-search-cigar')
      expect(form).toContain('input[type=submit][value="Find it"]')

    it 'displays a results view', =>
      mockView = new Backbone.View()
      spyOn(mockView, 'render').andReturn(el: 'I am a mock results view')
      spyOn(CigarFinderWeb.Views, 'CigarSearchResultsIndex').andReturn(mockView)
      renderView()
      expect(CigarFinderWeb.Views.CigarSearchResultsIndex).toHaveBeenCalledWith
        collection: collection
      expect($el.find('#js-cigar-search-results')).toContainHtml('I am a mock results view')

  describe 'performing a search', =>
    beforeEach =>
      spyOn(collection, 'fetch').andCallFake =>
        collection.reset()

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
