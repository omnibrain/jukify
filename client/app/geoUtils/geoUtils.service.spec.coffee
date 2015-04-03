'use strict'

describe 'Service: geoUtils', ->

  # load the service's module
  beforeEach module 'jukifyApp'

  # instantiate service
  geoUtils = undefined
  beforeEach inject (_geoUtils_) ->
    geoUtils = _geoUtils_

  it 'should do something', ->
    expect(!!geoUtils).toBe true