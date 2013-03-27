describe 'CigarFinderWeb.Views.CigarSearchForm', ->
  [view, $el, submitButton, performSearch] = []

  renderView = =>
    view = new CigarFinderWeb.Views.CigarSearchForm()
    $el = $(view.render().el)
    submitButton = view.$('input[type=submit]')
    performSearch = (cigar_name) =>
      view.$('.js-cigar-name').val(cigar_name)
      view.$('form').submit()

  beforeEach =>
    spyOn(Backbone.history, 'navigate')
    renderView()

  describe "rendering", =>
    it "displays a search form", =>
      expect($el).toContain('form.cigar-search-form')
      $form = $el.find('form.cigar-search-form')
      expect($form).toContain('input.js-cigar-name')
      expect($form).toContain("input[type=submit][value='Find it']")

    it "sets up autocomplete for the cigar name", =>
      spyOn($.prototype, 'typeahead')
      renderView()
      expect(view.$('.js-cigar-name').typeahead).toHaveBeenCalledWith
        source: CigarFinderWeb.cigars

  describe "performing a search", =>
    describe "when a cigar name has been entered", =>
      it "sets its button to a loading state", =>
        performSearch('Anything')
        waitsFor (=> submitButton.hasClass('disabled')),
          'Submit button was never disabled', 250
        runs =>
          expect(submitButton).toHaveAttr('value', 'Loading...')
          expect(submitButton).toHaveAttr('disabled')
          expect(submitButton).toHaveClass('disabled')

      it "navigates to the results page", =>
        performSearch('Tatuaje 7th Reserva')
        expect(Backbone.history.navigate).toHaveBeenCalledWith(
          'Tatuaje+7th+Reserva', trigger: true)

    describe "when no cigar has been entered", =>
      beforeEach =>
        performSearch('')

      it "leaves the submit button enabled", =>
        expect(submitButton).not.toHaveAttr('value', 'Loading...')
        expect(submitButton).not.toHaveAttr('disabled')
        expect(submitButton).not.toHaveClass('disabled')

      it "does not navigate", =>
        expect(Backbone.history.navigate).not.toHaveBeenCalled()

  describe "search loading", =>
    it "resets its form", =>
      performSearch('Illusione MK4')
      view.trigger('search:loaded')
      expect(view.$('.js-cigar-name')).toHaveValue('')
      expect(submitButton).toHaveValue('Find it')
