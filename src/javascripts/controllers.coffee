window.ionicApp
	.controller 'HomeController', [
		'$scope',
		'$http',
		'$ionicLoading',
		'$timeout',
		($s, $http, $loading, $timeout) ->
			$s.test = "Test is success!"

			$s.data = {}

			$s.clearSearch = ->
				$s.data.searchQuery = ''

			$s.doRefresh = ->
				$s.showLoading()
				$http
					method: 'GET'
					url: "#{window.ApiBaseUrl}books.json"
					isArray: true
				.success (data) ->
					$s.books = data
					$s.hideLoading()
					$s.$broadcast('scroll.refreshComplete')

			$s.showLoading = ->
				$loading.show
					template: '加载中'

			$s.hideLoading = ->
				$loading.hide()

			$s.doRefresh()
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