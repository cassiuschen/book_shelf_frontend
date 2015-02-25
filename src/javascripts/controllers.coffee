window.ionicApp
	.controller 'HomeController', [
		'$scope',
		($s) ->
			$s.test = "Test is success!"
	]

	.controller 'AboutController', [
		'$scope',
		($s) ->
			$s.test = "Test is success!"
	]