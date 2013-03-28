describe 'CigarFinderWeb.Views.CigarSearchResultsIndex', ->
  [collection, view, $el] = []

  beforeEach ->
    collection = new Backbone.Collection()
    spyOn(CigarFinderWeb.Views.CigarSearchResultsIndex.prototype, 'render').andCallThrough()
    view = new CigarFinderWeb.Views.CigarSearchResultsIndex(collection: collection)
    $el = $(view.render().el)

  describe 'collection resetting', ->
    it 'rerenders the view', ->
      collection.reset()
      expect(view.constructor.prototype.render.callCount).toBe(2)

  describe 'rendering', ->
    carried = { cigar_store: 'foo', carried: true }
    notCarried = { cigar_store: 'bar', carried: false }
    noAnswer = { cigar_store: 'baz', carried: null }

    beforeEach ->
      spyOn(CigarFinderWeb.Views, 'CigarSearchResult').andCallFake (args) ->
        render: -> el: "<div>#{args.model.get('cigar_store')}</div>"

    it 'an unstyled list', ->
      expect($el).toBe('ul.unstyled')

    it 'lists cigar stores grouped by if they carry a cigar', ->
      collection.reset([carried, notCarried, noAnswer])
      expect($el.children('li').length).toBe(3)

      expect($el).toContain('li#js-results-list-carried')
      list = $el.find('li#js-results-list-carried')
      expect(list).toContainHtml('Carried By')
      expect(list.find('ul')).toContainHtml('foo')

      expect($el).toContain('li#js-results-list-not-carried')
      list = $el.find('li#js-results-list-not-carried')
      expect(list).toContainHtml('Not Carried By')
      expect(list.find('ul')).toContainHtml('bar')

      expect($el).toContain('li#js-results-list-no-answer')
      list = $el.find('li#js-results-list-no-answer')
      expect(list).toContainHtml('No Information For')
      expect(list.find('ul')).toContainHtml('baz')

    it 'only displays groups that have results', ->
      collection.reset([carried, notCarried])

      expect($el).not.toContain('li#js-results-list-no-answer')
      expect($el).not.toContainHtml('No Information For')
      expect($el).not.toContainHtml('baz')
