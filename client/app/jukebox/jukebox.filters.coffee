
angular.module 'durationFilter', []
.filter 'formatMillis', ->
	return (millis)->
		minutes = Math.floor(millis / 60000)
		seconds = ((millis % 60000) / 1000).toFixed(0)
		return "#{minutes}:" + if seconds < 10 then "0#{seconds}" else "#{seconds}"
