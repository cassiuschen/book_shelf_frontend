window.ionicApp
	.controller 'HomeController', [
		'$scope',
		'$ionicLoading',
		'$timeout',
		($s, $loading, $timeout) ->
			$s.test = "Test is success!"

			$s.rawData = window.TestData
			$s.books = $s.rawData.books

			$s.doRefresh = ->
				$s.showLoading()
				$timeout ->
						$s.hideLoading()
						$s.$broadcast('scroll.refreshComplete')
					, 1000
			$s.showLoading = ->
				$loading.show
					template: '加载中'

			$s.hideLoading = ->
				$loading.hide()
	]

	.controller 'BookDetailController', [
		'$scope',
		'$http',
		'$stateParams',
		($s, $http, $params) ->
			$s.text = "Detail Test"
			$s.params = $params.BookId
			$s.info = window.TestData

			return
	]

	.controller 'DoubanInfoController', [
		'$scope',
		'$http',
		'$stateParams',
		($s, $http, $params) ->
	]

	.controller 'AboutController', [
		'$scope',
		($s) ->
			$s.test = "Test is success!"
	]

	.controller 'LoadingController', [
		'$scope',
		'$ionicLoading',
		($s, $loading) ->
			$s.show = ->
				$loading.show
					template: '加载中'

			$s.gide = ->
				$loading.hide()
	]