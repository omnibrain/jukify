'use strict'

angular.module 'jukifyApp'
.controller 'JukeboxCtrl', ($scope, $http, $state, socket) ->

	MAX_DISTANCE = 5000 # in m
	MAX_VOTE_DISTANCE = 100 # in m

	$scope.jukeboxes = []
	$scope.localized = false
	$scope.position = null

	$scope.address = {} # autocompletion

	$scope.addRangeCircle = (position)->
		options =
			radius: MAX_VOTE_DISTANCE
			center: { lat: position.coords.latitude, lng: position.coords.longitude }
			map: $scope.map
			strokeWeight: 1
			strokeColor: '#2ecc71'
			fillColor: '#2ecc71'
		new google.maps.Circle options

	$scope.createMarkers = (jukeboxes)->

		# single info window instance
		infowindow = new google.maps.InfoWindow

		# filter jukeboxes: only display jukeboxes closer than MAX_DISTANCE meters
		close_jukeboxes = _.filter jukeboxes, (jukebox)->
			MAX_DISTANCE > $scope.distance jukebox
			
		_.each close_jukeboxes, (jukebox)->

			# create marker
			marker = new google.maps.Marker
				map: $scope.map
				position: {lat: jukebox.lat, lng: jukebox.lng }
				title: jukebox.name

			# marker click event
			google.maps.event.addListener marker, 'click', (e)->
				infowindow.close()
				infowindow.setContent "<strong>#{jukebox.name}</strong><br>#{jukebox.address}"
				infowindow.open $scope.map, marker


	$scope.getJukeboxes = ->
		$http.get('/api/jukebox').success (jukeboxes) ->
			$scope.jukeboxes = jukeboxes
			$scope.createMarkers jukeboxes
			socket.syncUpdates 'jukebox', $scope.jukeboxes
	
	$scope.locateCallback = (position)->
			$scope.position = position
			$scope.localized = true
			$scope.map.setCenter
				lat: position.coords.latitude
				lng: position.coords.longitude
			$scope.addRangeCircle position
			$scope.getJukeboxes()

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



	# localize the client
	if navigator.geolocation
		navigator.geolocation.getCurrentPosition($scope.locateCallback)
