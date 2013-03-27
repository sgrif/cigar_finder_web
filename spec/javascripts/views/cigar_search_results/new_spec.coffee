describe "CigarFinderWeb.Views.NewCigarSearchResult", ->
  describe 'render', =>
    [view, $el] = []

    beforeEach =>
      spyOn(CigarFinderWeb.Collections.CigarStores, 'near').andReturn(new Backbone.Collection)
      view = new CigarFinderWeb.Views.NewCigarSearchResult()
      $el = null

    renderView = =>
      $el = $(view.render().el)

    it 'displays a list of nearby stores', =>
      CigarFinderWeb.Collections.CigarStores.near.andReturn(
        new Backbone.Collection([{id: 1, name: "Jim's"}, {id: 2, name: "Bob's"}]))
      renderView()
      expect($el.find('#js-new-result-cigar-store-id')).toContain(
        'option[value=1]:contains("Jim\'s")')
      expect($el.find('#js-new-result-cigar-store-id')).toContain(
        'option[value=2]:contains("Bob\'s")')
      expect($el.find('#js-new-result-cigar-store-id option').length).toBe(2)

    it 'displays stores near a location', =>
      view.location = 'Chicago'
      renderView()
      expect(CigarFinderWeb.Collections.CigarStores.near).toHaveBeenCalledWith('Chicago')
