describe "CigarFinderWeb.Views.CigarSearchResult", ->
  describe 'render', =>
    [model, view, $el] = []

    beforeEach =>
      model = new Backbone.Model(cigar_store: { name: "Jim's Cigars" })
      model.carriedDescription = ->
      view = new CigarFinderWeb.Views.CigarSearchResult(model: model)

    renderView = =>
      $el = $(view.render().el)

    it 'displays a list item', =>
      renderView()
      expect($el).toContain('dt')
      expect($el).toContain('dd')

    it 'displays the stores name', =>
      renderView()
      expect($el.find('dt')).toHaveText("Jim's Cigars")

    it 'displays whether or not the cigar is carried', =>
      spyOn(model, 'carriedDescription').andCallFake => 'I am carried'
      renderView()
      expect($el.find('dd')).toHaveText('I am carried')
      expect(model.carriedDescription).toHaveBeenCalled()
