describe "CigarFinderWeb.Collections.CigarStores", =>
  beforeEach =>
    spyOn(CigarFinderWeb.Services.LocationLoader, 'loadLocation').andCallFake (l, callback) =>
      callback(latitude: 1, longitude: -1)

  it "is a collection of cigar stores", ->
    collection = new CigarFinderWeb.Collections.CigarStores([{name: "Jim's"}])
    expect(collection.models).toEqual([jasmine.any(CigarFinderWeb.Models.CigarStore)])

  it "finds stores near a given location", =>
    CigarFinderWeb.Collections.CigarStores.near('Chicago')
    expect(CigarFinderWeb.Services.LocationLoader.loadLocation).toHaveBeenCalledWith(
      'Chicago', jasmine.any(Function))

  it "loads nearby stores from the api", =>
    spyOn(Backbone, 'ajax')
    collection = CigarFinderWeb.Collections.CigarStores.near()
    expect(collection).toEqual(jasmine.any(CigarFinderWeb.Collections.CigarStores))
    expect(Backbone.ajax).toHaveBeenCalled()
    args = Backbone.ajax.mostRecentCall.args[0]
    expect(args.url).toBe('/cigar_stores/nearby')
    expect(args.data).toEqual(latitude: 1, longitude: -1)
