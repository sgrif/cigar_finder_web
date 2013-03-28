describe "CigarFinderWeb.Views.CigarSearchResult", ->
  describe 'render', =>
    [model, view, $el] = []

    beforeEach =>
      model = new Backbone.Model(cigar_store: new Backbone.Model(name: "Jim's Cigars"))
      model.carriedDescription = ->
      view = new CigarFinderWeb.Views.CigarSearchResult(model: model)

    renderView = =>
      $el = $(view.render().el)

    it 'displays a list item', =>
      renderView()
      expect($el).toBe('li')

    it 'displays the stores name', =>
      renderView()
      expect($el).toHaveText("Jim's Cigars")
