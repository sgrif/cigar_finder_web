describe 'CigarFinderWeb.Views.CigarSearchForm', ->
  [view, $el, performSearch] = []

  renderView = =>
    form = $('<form>')
    view = new CigarFinderWeb.Views.CigarSearchForm()
    view.setElement(form).render()
    $el = view.$el

    performSearch = (cigar_name, location = '') =>
      view.$('.js-cigar-name').val(cigar_name)
      view.$('.js-search-location').val(location)
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
    sharedSearchExamples = =>
      it "sets its button to a loading state", =>
        submitButton = view.$(':submit')
        waitsFor (=> submitButton.hasClass('disabled')),
          'Submit button was never disabled', 250
        runs =>
          expect(submitButton).toHaveAttr('value', 'Loading...')
          expect(submitButton).toHaveAttr('disabled')
          expect(submitButton).toHaveClass('disabled')

    sharedNoSearchExamples = =>
      it "leaves the submit button enabled", =>
        submitButton = view.$(':submit')
        expect(submitButton).not.toHaveAttr('value', 'Loading...')
        expect(submitButton).not.toHaveAttr('disabled')
        expect(submitButton).not.toHaveClass('disabled')

      it "does not navigate", =>
        expect(Backbone.history.navigate).not.toHaveBeenCalled()

      it 'resets its form', =>
        expect(view.$('.js-cigar-name')).toHaveValue('')

    describe "when a cigar name has been entered", =>
      beforeEach =>
        performSearch('Tatuaje 7th Reserva')

      it "navigates to the results page", =>
        expect(Backbone.history.navigate).toHaveBeenCalledWith(
          'Tatuaje+7th+Reserva', trigger: true)

      sharedSearchExamples()

    describe "when no cigar has been entered", =>
      beforeEach =>
        performSearch('')

      sharedNoSearchExamples()

    describe "when the entered cigar and location are already displayed", =>
      beforeEach =>
        view.trigger('search:loaded', 'Illusione Mk Ultra')
        performSearch('Illusione Mk Ultra')

      sharedNoSearchExamples()

    describe "when the entered cigar is the same but location differs", =>
      beforeEach =>
        view.trigger('search:loaded', 'Tatuaje 7th Reserva')
        view.logQuery = true
        performSearch('Tatuaje 7th Reserva', 'Chicago')

      sharedSearchExamples()

    describe "when a location has been entered", =>
      beforeEach =>
        performSearch('Tatuaje 7th Reserva', 'Albuquerque, NM')

      it "navigates to the results page with a location", =>
        expect(Backbone.history.navigate).toHaveBeenCalledWith(
          'Tatuaje+7th+Reserva/Albuquerque%2C+NM', trigger: true)

      sharedSearchExamples()

  describe "search loading", =>
    it "resets its form", =>
      performSearch('Illusione MK4')
      view.trigger('search:loaded')
      expect(view.$('.js-cigar-name')).toHaveValue('')
      expect(view.$(':submit')).toHaveValue('Find it')
