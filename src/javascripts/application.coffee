window.ionicApp = angular.module 'BookShelf', [
	'ionic'
]

window.ApiBaseUrl = "http://lib.cassiuschen.me/api/"

window.ionicApp.config(["$httpProvider", (provider) ->
	provider.defaults.headers.common['Access-Control-Allow-Origin'] = '*'
	# LeanCloud Application ID
	provider.defaults.headers.common['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
	provider.defaults.headers.common['Access-Control-Allow-Headers'] = 'Content-Type, X-Requested-With'
	#provider.defaults.headers.common['Content-Type'] = "application/json"
])

window.ionicApp
	.config ['$stateProvider', '$urlRouterProvider', ($state, $url) ->
		$state
			.state 'tabs', {
				url: "/tab"
				abstract: true
				templateUrl: '../../tabs.html'
			}

			.state 'tabs.home', {
				url: '/home'
				views:
					'home-tab':
						templateUrl: "../../home.html"
						controller: "HomeController"
			}

			.state 'tabs.detail', {
				url: '/detail/:BookId'
				views:
					'home-tab':
						templateUrl: "../../detail.html"
						controller: "BookDetailController"
			}

			.state 'tabs.about', {
				url: '/about'
				views:
					'about-tab':
						templateUrl: "../../about.html"
						controller: "AboutController"
			}

		$url.otherwise "/tab/home"
	]