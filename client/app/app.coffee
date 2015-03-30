'use strict'

angular.module 'jukifyApp', [
	'ngCookies',
	'ngResource',
	'ngSanitize',
	'btford.socket-io',
	'ui.router',
	'ui.bootstrap',
	'ui.select',
]
.config ($stateProvider, $urlRouterProvider, $locationProvider, $compileProvider) ->
	# default url if nonexisting url is provided
	$urlRouterProvider
	.otherwise '/'

	$locationProvider.html5Mode true

	$compileProvider.aHrefSanitizationWhitelist /^\s*(https?|mailto|spotify):/
