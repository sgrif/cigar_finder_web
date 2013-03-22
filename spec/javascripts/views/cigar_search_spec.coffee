describe 'CigarFinderWeb.Views.CigarSearch', ->
  [collection, view, $el] = []

  renderView = =>
    collection = new CigarFinderWeb.Collections.CigarSearchResults()
    spyOn(collection, 'fetchCigar')
    view = new CigarFinderWeb.Views.CigarSearch(collection: collection)
    $el = $(view.render().el)

  beforeEach =>
    renderView()

  describe 'encodeCigarName', =>
    it 'replaces spaces with +', =>
      expect(view.encodeCigarName("Tatuaje 7th Reserva")).toBe("Tatuaje+7th+Reserva")

    it 'squashes multiple spaces', =>
      expect(view.encodeCigarName("Illusione   MK4")).toBe("Illusione+MK4")

    it 'escapes uri unsafe characters', =>
      expect(view.encodeCigarName("Jake & Harley's Cigar")).toBe("Jake+%26+Harley's+Cigar")

  describe 'render', =>
    it 'displays a search form', =>
      expect($el).toContain('form#new-search')
      form = $el.find('form#new-search')
      expect(form).toContain('input#new-search-cigar')
      expect(form).toContain('input[type=submit][value="Find it"]')

    mockView = (viewClass) =>
      testDouble = new Backbone.View()
      spyOn(testDouble, 'render').andReturn(el: "I am a mock of #{viewClass}")
      spyOn(CigarFinderWeb.Views, viewClass).andReturn(testDouble)

    it 'displays a results view', =>
      mockView("CigarSearchResultsIndex")
      renderView()
      expect(CigarFinderWeb.Views.CigarSearchResultsIndex).toHaveBeenCalledWith
        collection: collection
      expect($el.find('#js-cigar-search-results')).toContainHtml('I am a mock of CigarSearchResultsIndex')

    it 'displays a map view', =>
      mockView("MapView")
      renderView()
      expect(CigarFinderWeb.Views.MapView).toHaveBeenCalledWith
        collection: collection
      expect($el.find('#js-cigar-map')).toContainHtml('I am a mock of MapView')


  describe 'performing a search', =>
    beforeEach =>
      collection.fetchCigar.andCallFake =>
        collection.reset()
      spyOn(Backbone.history, 'navigate')

    performSearch = (cigar) =>
      $el.find('#new-search-cigar').val(cigar)
      $el.find('#new-search').trigger('submit')

    it 'queries the api', =>
      performSearch('Tatuaje 7th Reserva')
      expect(collection.fetchCigar).toHaveBeenCalledWith('Tatuaje 7th Reserva')

    it 'resets the form', =>
      performSearch('Anything')
      expect($el.find('#new-search-cigar').val()).toBe('')

    it 'displays the cigar name', =>
      performSearch('Illusione MK4')
      expect($el.find('#js-cigar-name').html()).toBe('Illusione MK4')

    it 'changes the url', =>
      performSearch('Tatuaje 7th Reserva')
      expect(Backbone.history.navigate).toHaveBeenCalledWith "Tatuaje+7th+Reserva",
        trigger: false
