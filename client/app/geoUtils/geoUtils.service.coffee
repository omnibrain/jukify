'use strict'

angular.module 'jukifyApp'
.factory 'geoUtils', ->

	# cache for the client's position
	# Could be made time dependent (refresh after X mins) but not for now :)
	positionCache = null

	getPosition: (callback)->
		# localize the client
		if positionCache and callback
			callback positionCache
		else if navigator.geolocation
			navigator.geolocation.getCurrentPosition (position)->
				console.log 'Client was located'
				positionCache = position
				if callback then callback position
		else
			console.error 'Error locating client'
	
	distance: (position)->
		if not positionCache
			console.error 'Tried to get distance before client was located'
			return

		p1 =
			latitude: positionCache.coords.latitude
			longitude: positionCache.coords.longitude
		p2 =
			latitude: position.lat
			longitude: position.lng

		return geolib.getDistance p1, p2

	located: ->
		return positionCache != null

