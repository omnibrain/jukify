'use strict'

describe 'Controller: JukeboxCtrl', ->

  # load the controller's module
  beforeEach module 'jukifyApp'
  JukeboxCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    JukeboxCtrl = $controller 'JukeboxCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
