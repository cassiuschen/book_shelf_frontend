window.ionicApp = angular.module 'BookShelf', [
	'ionic'
]

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

			.state 'tabs.about', {
				url: '/about'
				views:
					'about-tab':
						templateUrl: "../../about.html"
						controller: "AboutController"
			}

		$url.otherwise "/tab/home"
	]