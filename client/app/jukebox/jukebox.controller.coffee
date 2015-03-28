'use strict'

angular.module 'jukifyApp'
.controller 'JukeboxCtrl', ($scope, $http, socket) ->
	console.log socket
	$scope.songs = []

	$http.get('/api/jukebox').success (jukeboxes) ->
		$scope.jukeboxes = jukeboxes
		socket.syncUpdates 'jukebox', $scope.jukeboxes

	$scope.addJukebox = ->
		return if $scope.name is '' or $scope.addressRaw is ''
		geocoder = new google.maps.Geocoder()
		geocoder.geocode
			address: $scope.addressRaw
			(results, status)->
				if status == google.maps.GeocoderStatus.OK
					console.log results[0]
					bestMatch = results[0]
					window.address = bestMatch
					$http.post '/api/jukebox',
						name: $scope.name
						address: bestMatch.formatted_address
						lat: bestMatch.geometry.location.k
						lng: bestMatch.geometry.location.D
						info: '' # optional
				else
					console.log 'error finding address'
		
	$scope.newSong = ''

	$scope.deleteSong = (thing) ->
		$http.delete '/api/songs/' + song._id

	$scope.$on '$destroy', ->
		socket.unsyncUpdates 'song'

