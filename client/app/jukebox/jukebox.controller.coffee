'use strict'

angular.module 'jukifyApp'
.controller 'JukeboxCtrl', ($scope, $http, $state, socket) ->

	$scope.jukeboxes = []
	$scope.localized = false
	$scope.position = null
	$scope.localization_error = false

	# localize the client
	if navigator.geolocation
		locateCallback = (position)->
			$scope.position = position
			$scope.localized = true
			$http.get('/api/jukebox').success (jukeboxes) ->
				$scope.jukeboxes = jukeboxes
				socket.syncUpdates 'jukebox', $scope.jukeboxes

		navigator.geolocation.getCurrentPosition(locateCallback)

	$scope.addJukebox = ->
		return if $scope.name is '' or $scope.address.formatted_address is ''
		address = $scope.address.selected
		$http.post '/api/jukebox',
			name: $scope.name
			address: address.formatted_address
			lat: address.geometry.location.lat
			lng: address.geometry.location.lng
			info: '' # optional
		.success (data)->
			$scope.showJukebox(data)
		
		
	$scope.showJukebox = (jukebox)->
		$state.go('jukebox_show', { slug: jukebox.slug })
	
	$scope.address = {}

	$scope.refreshAddresses = (address)->
		params =
			address: address
			sensor: true
		$http.get 'http://maps.googleapis.com/maps/api/geocode/json', { params: params }
			.then (response)->
				$scope.addresses = response.data.results

	$scope.distance = (jukebox)->
		from = new google.maps.LatLng(jukebox.lat, jukebox.lng)
		to   = new google.maps.LatLng($scope.position.coords.latitude, $scope.position.coords.longitude)
		return google.maps.geometry.spherical.computeDistanceBetween(from, to)
