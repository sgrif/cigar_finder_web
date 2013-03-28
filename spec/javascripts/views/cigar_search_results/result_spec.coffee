describe "CigarFinderWeb.Views.CigarSearchResult", ->
  describe 'render', =>
    [model, view, $div, $el] = []

    beforeEach =>
      model = new CigarFinderWeb.Models.CigarSearchResult(cigar_store: {name: "Jim's Cigars"})
      spyOn(model, 'reportCarried')
      spyOn(model, 'reportNotCarried')
      spyOn(model, 'reportIncorrect')
      view = new CigarFinderWeb.Views.CigarSearchResult(model: model)
      $div = $('<div>')
      $('body').append($div)

    afterEach =>
      view.remove()
      $div.remove()

    renderView = =>
      $el = $(view.render().el)
      $div.html($el)

    it 'displays a list item', =>
      renderView()
      expect($el).toBe('li')

    it 'displays the stores name', =>
      renderView()
      expect($el).toContainHtml("Jim's Cigars")

    sharedIncorrectInfoExamples = (carried) =>
      beforeEach =>
        model.set('carried', carried)
        renderView()
        view.$('#js-report-incorrect').click()

      it 'has an incorrect info link', =>
        expect(view.$el).toContain('#js-report-incorrect')
        expect(model.reportIncorrect).toHaveBeenCalled()

    describe 'cigar is carried by store', =>
      sharedIncorrectInfoExamples(true)

    describe 'cigar is not carried by store', =>
      sharedIncorrectInfoExamples(false)

    describe 'no information on store', =>
      beforeEach =>
        model.set('carried', null)
        renderView()

      it "displays a link to mark the result as carried", =>
        expect($el).toContain('#js-report-carried')
        view.$('#js-report-carried').click()
        expect(model.reportCarried).toHaveBeenCalled()

      it "displays a link to mark the result as not carried", =>
        expect($el).toContain('#js-report-not-carried')
        view.$('#js-report-not-carried').click()
        expect(model.reportNotCarried).toHaveBeenCalled()
