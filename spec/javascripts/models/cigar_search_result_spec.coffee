describe 'CigarFinderWeb.Models.CigarSearchResult', ->
  it 'creates a cigar store model with the given attributes', ->
    cigarStore = jasmine.createSpy('CigarFinderWeb.Models.CigarStore')
    spyOn(CigarFinderWeb.Models, 'CigarStore').andReturn(cigarStore)
    cigar_store_attrs =
      name: "Jim's Cigars"
      latitude: 1
      longitude: -1
    model = new CigarFinderWeb.Models.CigarSearchResult(cigar_store: cigar_store_attrs)
    expect(CigarFinderWeb.Models.CigarStore).toHaveBeenCalledWith(cigar_store_attrs)
    expect(model.get('cigar_store')).toBe(cigarStore)

  it 'says yes if a cigar is carried', ->
    result = new CigarFinderWeb.Models.CigarSearchResult({carried: true})
    expect(result.carriedDescription()).toEqual('Yes')
  it 'says no if a cigar is not carried', ->
    result = new CigarFinderWeb.Models.CigarSearchResult({carried: false})
    expect(result.carriedDescription()).toEqual('No')
  it 'it says I dont know if it has no data on if a cigar is carried', ->
    result = new CigarFinderWeb.Models.CigarSearchResult({carried: null})
    expect(result.carriedDescription()).toEqual("I don't know")
