class CigarFinderWeb.Models.CigarSearchResult extends Backbone.Model
  urlRoot: '/cigar_search_results'

  initialize: ->
    if @get('cigar_store')
      @set('cigar_store', new CigarFinderWeb.Models.CigarStore(@get('cigar_store')))
      @set('cigar_store_id', @get('cigar_store').get('id'))

  reportCarried: => @save({}, method: 'POST', url: @urlRoot + '/report_carried')
  reportNotCarried: => @save({}, method: 'POST', url: @urlRoot + '/report_not_carried')

  reportIncorrect: =>
    throw new Error("Cannot report no information as incorrect") unless @get('carried')?
    if @get('carried') then @reportNotCarried() else @reportCarried()
