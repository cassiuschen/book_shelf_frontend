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
				.error ->
					$rs.hideLoading()
					$rs.showLoading("当前服务有问题，请稍后再试！")
					$timeout ->
							$rs.hideLoading()
						,1000
			$s.getInfo()
			

			return
	]

	.controller 'BorrowController', [
		'$scope',
		'$rootScope',
		'$http',
		'$ionicLoading',
		'$timeout',
		'$stateParams',
		($s, $rs, $http, $loading, $timeout, $params) ->
			$s.info = {}

			$s.getTitle = ->
				$rs.showLoading("请稍后...")
				$http
						method: 'GET'
						url: "#{window.ApiBaseUrl}book.json"
						params:
							id: $params.BookId
							attr: 'title'
					.success (data) ->
						$s.info.title = data.result
						$rs.hideLoading()
					.error ->
						$rs.hideLoading()
						$s.showLoading("当前网络有问题，请稍后再试！")
						$timeout ->
								$rs.hideLoading()
							,1000
			$s.getTitle()

			$s.postApplication = ->
				$rs.showLoading()
				$http
						method: "POST"
						url: "#{window.ApiBaseUrl}borrow/#{$params.BookId}.json"
						data:
							borrow:
								target: $s.info.name
								phone: $s.info.phone
					.success (data) ->
						$rs.hideLoading()
						if data.status == 200
							$rs.showLoading("申请成功！")
						else
							$rs.showLoading("当前无法提交申请\n请稍后再试")
						$timeout ->
								$rs.hideLoading()
							, 1000
					.error ->
						$rs.hideLoading()
						$rs.showLoading("当前无法提交申请\n请稍后再试")
						$timeout ->
								$rs.hideLoading()
							, 1000



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