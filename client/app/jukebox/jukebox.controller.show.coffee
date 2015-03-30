'use strict'

angular.module 'jukifyApp'
.controller 'JukeboxShowCtrl', ($scope, $http, $stateParams, socket) ->

	$scope.jukebox = {}
	$scope.playlist = []

	$http.post '/api/jukebox/q', { slug: $stateParams.slug }
		.success (jukebox) ->
			$scope.jukebox = jukebox
			$http.post '/api/songs/q', { _jukebox: $scope.jukebox.id }
				.success (playlist) ->
					$scope.playlist = playlist
					socket.syncUpdates 'song', $scope.playlist
	
	$scope.song = {}

	$scope.refreshSongs = (song)->
		return if song.length < 2
		params =
			q: song
			type: 'track'
		$http.get 'https://api.spotify.com/v1/search', { params: params }
			.then (response)->
				$scope.songs = response.data.tracks.items

	$scope.addSong = ->
		return if $scope.song.name = ''
		song = $scope.song.selected
		console.log song
		$http.post '/api/songs',
			title: song.name
			album: song.album.name
			artist: song.artists[0].name
			length: song.duration_ms
			uri: song.uri,
			_jukebox: $scope.jukebox._id
	
	$scope.upvote = (song)->
		params =
			votes: song.votes + 1
		$http.put '/api/songs/' + song._id, { votes: song.votes + 1 }

