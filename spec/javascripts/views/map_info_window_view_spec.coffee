describe "CigarFinderWeb.Views.MapInfoWindowView", ->
  [model, view, marker, map, infoWindow] = []

  beforeEach ->
    window.google =
      maps:
        InfoWindow: ->
    infoWindow = jasmine.createSpyObj('infoWindow', ['open', 'close'])
    spyOn(google.maps, 'InfoWindow').andReturn(infoWindow)
    model = new Backbone.Model(name: "Jim's Cigars", latitude: 1, longitude: -1, address: '100 Main Street Pleasantville')
    map = jasmine.createSpy('map')
    marker = jasmine.createSpyObj('marker', ['getMap'])
    marker.getMap.andReturn(map)
    view = new CigarFinderWeb.Views.MapInfoWindowView(model: model)

  describe "rendering", ->
    beforeEach ->
      spyOn(view, 'template').andReturn('I am a mock of the views template')
      view.render(marker)

    it "creates a new google infowindow", ->
      expect(google.maps.InfoWindow).toHaveBeenCalledWith
        content: 'I am a mock of the views template'

    it "removes any other visible infowindows", ->
      otherView = new CigarFinderWeb.Views.MapInfoWindowView(model: model)
      spyOn(otherView, 'remove')
      otherView.render(marker)
      view.render(marker)
      expect(otherView.remove).toHaveBeenCalled()

    it "opens its infowindow using the given marker", ->
      expect(infoWindow.open).toHaveBeenCalledWith(map, marker)

  describe "infowindow content", ->
    [$el] = []

    beforeEach ->
      $el = view.$el
      $el.html(view.template(cigar_store: model))

    it "should display the store's name", ->
      expect($el).toContainHtml("<h6>Jim's Cigars</h6>")
