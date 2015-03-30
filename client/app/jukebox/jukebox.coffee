'use strict'

angular.module 'jukifyApp'
.config ($stateProvider, $urlRouterProvider) ->

  $stateProvider.state 'jukebox_index',
    url: '/jukebox'
    templateUrl: 'app/jukebox/jukebox.html'
    controller: 'JukeboxCtrl'
  $stateProvider.state 'jukebox_show',
    url: '/jukebox/:slug'
    templateUrl: 'app/jukebox/jukebox_show.html'
    controller: 'JukeboxShowCtrl'
