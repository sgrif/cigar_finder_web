describe 'CigarFinderWeb.Views.CigarSearchResultsIndex', ->
  [collection, view, $el] = []

  beforeEach =>
    collection = new Backbone.Collection()
    view = new CigarFinderWeb.Views.CigarSearchResultsIndex(collection: collection)
    $el = $(view.render().el)

  describe 'rendering', =>
    it 'displays a horizontal description list', =>
      expect($el).toBe('dl.dl-horizontal')

  describe 'collection resetting', =>
    it 'resets the list', =>
      $el.html('<dt>A store</dt><dd>Yes</dd>')
      collection.reset()
      expect($el.html()).toBe('')

    it 'displays a list of results', =>
      spyOn(CigarFinderWeb.Views, 'CigarSearchResult').andCallFake (args) =>
        render: -> el: "<div>#{args.model.get('result')}</div>"
      collection.reset([{result: 'foo'}, {result: 'bar'}])
      expect($el.find('div').length).toBe(2)
      expect($el.find('div:first').html()).toBe('foo')
      expect($el.find('div:last').html()).toBe('bar')
