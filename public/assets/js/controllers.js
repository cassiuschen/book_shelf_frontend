window.ionicApp.controller('HomeController', [
  '$scope', '$http', '$ionicLoading', '$timeout', function($s, $http, $loading, $timeout) {
    $s.test = "Test is success!";
    $s.data = {};
    $s.clearSearch = function() {
      return $s.data.searchQuery = '';
    };
    $s.doRefresh = function() {
      $s.showLoading();
      return $http({
        method: 'GET',
        url: window.ApiBaseUrl + "books.json",
        isArray: true
      }).success(function(data) {
        $s.books = data;
        $s.hideLoading();
        return $s.$broadcast('scroll.refreshComplete');
      });
    };
    $s.showLoading = function() {
      return $loading.show({
        template: '加载中'
      });
    };
    $s.hideLoading = function() {
      return $loading.hide();
    };
    return $s.doRefresh();
  }
]).controller('BookDetailController', [
  '$scope', '$http', '$stateParams', function($s, $http, $params) {
    $s.text = "Detail Test";
    $s.params = $params.BookId;
    $s.info = window.TestData;
  }
]).controller('DoubanInfoController', ['$scope', '$http', '$stateParams', function($s, $http, $params) {}]).controller('AboutController', [
  '$scope', function($s) {
    return $s.test = "Test is success!";
  }
]).controller('LoadingController', [
  '$scope', '$ionicLoading', function($s, $loading) {
    $s.show = function() {
      return $loading.show({
        template: '加载中'
      });
    };
    return $s.gide = function() {
      return $loading.hide();
    };
  }
]);
