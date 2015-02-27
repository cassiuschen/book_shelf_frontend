window.ionicApp
	.controller 'HomeController', [
		'$scope',
		'$rootScope',
		'$http',
		'$ionicLoading',
		'$timeout',
		($s, $rs, $http, $loading, $timeout) ->
			$s.data = {}

			$s.clearSearch = ->
				$s.data.searchQuery = ''

			$s.doRefresh = ->
				$rs.showLoading()
				$http
					method: 'GET'
					url: "#{window.ApiBaseUrl}books.json"
					isArray: true
				.success (data) ->
					$s.books = data
					$rs.hideLoading()
					$s.$broadcast('scroll.refreshComplete')

			$s.doRefresh()
	]

	.controller 'BookDetailController', [
		'$scope',
		'$rootScope',
		'$http',
		'$ionicLoading',
		'$timeout',
		'$stateParams',
		($s, $rs, $http, $loading, $timeout, $params) ->
			$s.book = {}
			$s.getInfo = ->
				$rs.showLoading()
				$http
					method: 'GET'
					url: "#{window.ApiBaseUrl}book.json"
					params:
						id: $params.BookId
					isArray: true
				.success (data) ->
					$s.book = data
					$s.rating = Math.round($s.book.rating.average / 2)
					$s.rating_up = [0...$s.rating]
					$s.rating_down = [0...(5 - $s.rating)]
					$s.hideLoading()
					$s.$broadcast('scroll.refreshComplete')
			$s.getInfo()
			

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