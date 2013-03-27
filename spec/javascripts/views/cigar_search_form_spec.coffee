describe 'CigarFinderWeb.Views.CigarSearchForm', ->
  [view, $el, submitButton, performSearch] = []

  renderView = =>
    form = $('<form>')
    view = new CigarFinderWeb.Views.CigarSearchForm()
    view.setElement(form).render()
    $el = view.$el
    submitButton = view.$('input[type=submit]')

    performSearch = (cigar_name) =>
      view.$('.js-cigar-name').val(cigar_name)
      $el.submit()

  beforeEach =>
    spyOn(Backbone.history, 'navigate')
    renderView()

  describe "rendering", =>
    it "displays a search form", =>
      expect($el).toHaveClass('cigar-search-form')
      expect($el).toContain('input.js-cigar-name')
      expect($el).toContain("input[type=submit][value='Find it']")

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

    sharedDoesNotSubmitExamples = =>
      it "leaves the submit button enabled", =>
        submitButton = view.$(':submit')
        expect(submitButton).not.toHaveAttr('value', 'Loading...')
        expect(submitButton).not.toHaveAttr('disabled')
        expect(submitButton).not.toHaveClass('disabled')

      it "does not navigate", =>
        expect(Backbone.history.navigate).not.toHaveBeenCalled()

      it 'resets its form', =>
        expect(view.$('.js-cigar-name')).toHaveValue('')

    describe "when no cigar has been entered", =>
      beforeEach =>
        performSearch('')

      sharedDoesNotSubmitExamples()

    describe "when the entered cigar is already displayed", =>
      beforeEach =>
        view.trigger('search:loaded', 'Illusione Mk Ultra')
        performSearch('Illusione Mk Ultra')

      sharedDoesNotSubmitExamples()

  describe "search loading", =>
    it "resets its form", =>
      performSearch('Illusione MK4')
      view.trigger('search:loaded')
      expect(view.$('.js-cigar-name')).toHaveValue('')
      expect(submitButton).toHaveValue('Find it')
