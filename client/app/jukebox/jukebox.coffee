'use strict'

angular.module 'jukifyApp'
.config ($stateProvider) ->
  $stateProvider.state 'jukebox',
    url: '/jukebox'
    templateUrl: 'app/jukebox/jukebox.html'
    controller: 'JukeboxCtrl'
