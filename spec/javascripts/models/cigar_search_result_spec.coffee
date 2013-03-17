describe 'CigarFinderWeb.Models.CigarSearchResult', ->
  it 'says yes if a cigar is carried', ->
    result = new CigarFinderWeb.Models.CigarSearchResult({carried: true})
    expect(result.carriedDescription()).toEqual('Yes')
  it 'says no if a cigar is not carried', ->
    result = new CigarFinderWeb.Models.CigarSearchResult({carried: false})
    expect(result.carriedDescription()).toEqual('No')
  it 'it says I dont know if it has no data on if a cigar is carried', ->
    result = new CigarFinderWeb.Models.CigarSearchResult({carried: null})
    expect(result.carriedDescription()).toEqual("I don't know")
