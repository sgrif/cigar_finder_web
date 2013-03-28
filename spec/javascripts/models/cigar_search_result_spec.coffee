describe 'CigarFinderWeb.Models.CigarSearchResult', ->
  [model, cigarStore, cigar_store_attrs, url] = []

  beforeEach =>
    cigarStore = jasmine.createSpyObj('CigarFinderWeb.Models.CigarStore', ['get'])
    spyOn(CigarFinderWeb.Models, 'CigarStore').andReturn(cigarStore)
    cigar_store_attrs =
      name: "Jim's Cigars"
      latitude: 1
      longitude: -1
    model = new CigarFinderWeb.Models.CigarSearchResult(cigar_store: cigar_store_attrs)
    url = null

  spyOnAjax = (carried) =>
    spyOn(Backbone, 'ajax').andCallFake (options) =>
      options.success(carried: carried)
      url = options.url

  it 'creates a cigar store model with the given attributes', ->
    expect(CigarFinderWeb.Models.CigarStore).toHaveBeenCalledWith(cigar_store_attrs)
    expect(model.get('cigar_store')).toBe(cigarStore)

  describe 'no information for cigar/store', =>
    beforeEach =>
      model.set('carried', null)

    it 'reports a cigar as carried', =>
      spyOnAjax(true)
      model.reportCarried()
      expect(Backbone.ajax).toHaveBeenCalled()
      expect(url).toBe('/cigar_search_results/report_carried')
      expect(model.get('carried')).toBe(true)

    it 'reports a cigar as not carried', =>
      spyOnAjax(false)
      model.reportNotCarried()
      expect(Backbone.ajax).toHaveBeenCalled()
      expect(url).toBe('/cigar_search_results/report_not_carried')
      expect(model.get('carried')).toBe(false)

    it 'cannot be reported as incorrect', =>
      expect(-> model.reportIncorrect()).toThrow("Cannot report no information as incorrect")

  describe 'cigar is carried by store', =>
    beforeEach =>
      model.set('carried', true)

    it 'can be reported as incorrect', =>
      spyOnAjax(false)
      model.reportIncorrect()
      expect(Backbone.ajax).toHaveBeenCalled()
      expect(url).toBe('/cigar_search_results/report_not_carried')
      expect(model.get('carried')).toBe(false)

  describe 'cigar is not carried by store', =>
    beforeEach =>
      model.set('carried', false)

    it 'can be reported as incorrect', =>
      spyOnAjax(true)
      model.reportIncorrect()
      expect(Backbone.ajax).toHaveBeenCalled()
      expect(url).toBe('/cigar_search_results/report_carried')
      expect(model.get('carried')).toBe(true)
