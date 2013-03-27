describe 'CigarFinderWeb.Views.CigarSearch', ->
  [collection, view, $el, mockViews] = []

  mockView = (viewClass) =>
    testDouble = new Backbone.View()
    spyOn(testDouble, 'render').andCallFake ->
      @$el.html("I am a mock of #{viewClass}")
      this
    spyOn(CigarFinderWeb.Views, viewClass).andReturn(testDouble)
    mockViews[viewClass] = testDouble

  renderView = =>
    collection = new CigarFinderWeb.Collections.CigarSearchResults()
    spyOn(collection, 'fetchCigar')
    view = new CigarFinderWeb.Views.CigarSearch(collection: collection)
    $el = $(view.render().el)

  beforeEach =>
    mockViews = []
    mockView('CigarSearchResultsIndex')
    mockView('MapView')
    mockView('CigarSearchForm')
    renderView()

  describe 'render', =>
    it 'displays a search form', =>
      renderView()
      expect(CigarFinderWeb.Views.CigarSearchForm).toHaveBeenCalled()
      expect($el.find('#js-new-search')).toContainHtml('I am a mock of CigarSearchForm')

    it 'displays a results view', =>
      renderView()
      expect(CigarFinderWeb.Views.CigarSearchResultsIndex).toHaveBeenCalledWith
        collection: collection
      expect($el.find('#js-cigar-search-results')).toContainHtml('I am a mock of CigarSearchResultsIndex')

    it 'displays a map view', =>
      renderView()
      expect(CigarFinderWeb.Views.MapView).toHaveBeenCalledWith
        collection: collection
      expect($el.find('#js-cigar-map')).toContainHtml('I am a mock of MapView')

  describe 'performing a search', =>
    beforeEach =>
      spyOn(mockViews['CigarSearchForm'], 'trigger')
      collection.fetchCigar.andCallFake =>
        collection.reset()
      spyOn(Backbone.history, 'navigate')

    it 'queries the api', =>
      view.performSearch('Tatuaje 7th Reserva')
      expect(collection.fetchCigar).toHaveBeenCalledWith('Tatuaje 7th Reserva')

    it 'displays the cigar name', =>
      view.performSearch('Illusione MK4')
      expect($el.find('#js-cigar-name').html()).toBe('Illusione MK4')

    it 'resets the form', =>
      view.performSearch('El Rey Del Mundo')
      expect(mockViews['CigarSearchForm'].trigger).toHaveBeenCalledWith(
        'search:loaded', 'El Rey Del Mundo')
