'use strict'

angular.module 'jukifyApp', [
	'ngCookies',
	'ngResource',
	'ngSanitize',
	'btford.socket-io',
	'ui.router',
	'ui.bootstrap',
	'ui.select',
	'customFilters',
	'ngMap',
]
.config ($stateProvider, $urlRouterProvider, $locationProvider, $compileProvider) ->
	# default url if nonexisting url is provided
	$urlRouterProvider
	.otherwise '/'

	$locationProvider.html5Mode true

	$compileProvider.aHrefSanitizationWhitelist /^\s*(https?|mailto|spotify):/
.constant 'settings',
	maxDistance: 5000 # in m
	maxVotingDistance: 200 # in m
	
