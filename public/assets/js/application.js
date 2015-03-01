window.ionicApp = angular.module('BookShelf', ['ionic']);

window.ApiBaseUrl = "http://192.168.31.119:3000/api/";

window.ionicApp.config([
  "$httpProvider", function(provider) {
    provider.defaults.headers.common['Access-Control-Allow-Origin'] = '*';
    provider.defaults.headers.common['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS';
    return provider.defaults.headers.common['Access-Control-Allow-Headers'] = 'Content-Type, X-Requested-With';
  }
]);

window.ionicApp.run([
  '$rootScope', '$http', '$ionicLoading', '$timeout', function($s, $http, $loading, $timeout) {
    $s.showLoading = function(text) {
      if (text == null) {
        text = "加载中";
      }
      return $loading.show({
        template: text
      });
    };
    return $s.hideLoading = function() {
      return $loading.hide();
    };
  }
]);

window.ionicApp.config([
  '$stateProvider', '$urlRouterProvider', function($state, $url) {
    $state.state('tabs', {
      url: "/tab",
      abstract: true,
      templateUrl: '../../tabs.html'
    }).state('tabs.home', {
      url: '/home',
      views: {
        'home-tab': {
          templateUrl: "../../home.html",
          controller: "HomeController"
        }
      }
    }).state('tabs.detail', {
      url: '/home/detail/:BookId',
      views: {
        'home-tab': {
          templateUrl: "../../detail.html",
          controller: "BookDetailController"
        }
      }
    }).state('tabs.borrow', {
      url: '/home/applicate/:BookId',
      views: {
        'home-tab': {
          templateUrl: "../../application.html",
          controller: 'BorrowController'
        }
      }
    }).state('tabs.about', {
      url: '/about',
      views: {
        'about-tab': {
          templateUrl: "../../about.html",
          controller: "AboutController"
        }
      }
    });
    return $url.otherwise("/tab/home");
  }
]);
