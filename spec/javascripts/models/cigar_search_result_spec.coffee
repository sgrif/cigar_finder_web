describe 'CigarFinderWeb.Models.CigarSearchResult', ->
  it 'creates a cigar store model with the given attributes', ->
    cigarStore = jasmine.createSpyObj('CigarFinderWeb.Models.CigarStore', ['get'])
    spyOn(CigarFinderWeb.Models, 'CigarStore').andReturn(cigarStore)
    cigar_store_attrs =
      name: "Jim's Cigars"
      latitude: 1
      longitude: -1
    model = new CigarFinderWeb.Models.CigarSearchResult(cigar_store: cigar_store_attrs)
    expect(CigarFinderWeb.Models.CigarStore).toHaveBeenCalledWith(cigar_store_attrs)
    expect(model.get('cigar_store')).toBe(cigarStore)
