describe 'CigarFinderWeb.Models.CigarSearchResult', ->
  it 'should be defined', ->
    expect(CigarFinderWeb.Models.CigarSearchResult).toBeDefined()
  it 'can be instaniated', ->
    search_result = new CigarFinderWeb.Models.CigarSearchResult()
    expect(search_result).not.toBeNull()
