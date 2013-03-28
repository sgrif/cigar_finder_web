describe "CigarFinderWeb.Views.CigarSearchResult", ->
  describe 'render', =>
    [model, view, $div, $el] = []

    beforeEach =>
      model = new Backbone.Model(cigar_store: new Backbone.Model(name: "Jim's Cigars"))
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

    describe 'on hover', =>
      beforeEach => spyOn(model, 'save')

      sharedIncorrectInfoExamples = =>
        beforeEach =>
          renderView()
          view.$('#js-report-incorrect').click()

        it 'has an incorrect info link', =>
          expect(view.$el).toContain('#js-report-incorrect')
          expect(model.save).toHaveBeenCalled()

      describe 'cigar is carried by store', =>
        beforeEach =>
          model.set('carried', true)

        sharedIncorrectInfoExamples()
        it "saves the result as not carried", =>
          expect(model.get('carried')).toBe(false)

      describe 'cigar is not carried by store', =>
        beforeEach =>
          model.set('caried', false)

        sharedIncorrectInfoExamples()
        it 'saves the result as carried', =>
          expect(model.get('carried')).toBe(true)

      describe 'no information on store', =>
        beforeEach =>
          model.set('carried', null)
          renderView()

        it "displays a link to mark the result as carried", =>
          expect($el).toContain('#js-report-carried')
          view.$('#js-report-carried').click()
          expect(model.get('carried')).toBe(true)
          expect(model.save).toHaveBeenCalled()

        it "displays a link to mark the result as not carried", =>
          expect($el).toContain('#js-report-not-carried')
          view.$('#js-report-not-carried').click()
          expect(model.get('carried')).toBe(false)
          expect(model.save).toHaveBeenCalled()
