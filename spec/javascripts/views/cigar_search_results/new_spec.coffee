describe "CigarFinderWeb.Views.NewCigarSearchResult", ->
  describe 'render', =>
    [view, $el] = []

    beforeEach =>
      spyOn(CigarFinderWeb.Collections.CigarStores, 'nearbyStores')
      view = new CigarFinderWeb.Views.NewCigarSearchResult()
      $el = null

    renderView = =>
      $el = $(view.render().el)

    it 'displays a list of nearby stores', =>
      CigarFinderWeb.Collections.CigarStores.nearbyStores.andReturn(
        new Backbone.Collection([{id: 1, name: "Jim's"}, {id: 2, name: "Bob's"}]))
      renderView()
      expect($el.find('#js-new-result-cigar-id')).toContain(
        'option[value=1]:contains("Jim\'s")')
      expect($el.find('#js-new-result-cigar-id')).toContain(
        'option[value=2]:contains("Bob\'s")')
      expect($el.find('#js-new-result-cigar-id option').length).toBe(2)