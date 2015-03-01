window.ionicApp.controller('HomeController', [
  '$scope', '$rootScope', '$http', '$ionicLoading', '$timeout', function($s, $rs, $http, $loading, $timeout) {
    $s.data = {};
    $s.clearSearch = function() {
      return $s.data.searchQuery = '';
    };
    $s.doRefresh = function() {
      $rs.showLoading();
      return $http({
        method: 'GET',
        url: window.ApiBaseUrl + "books.json",
        isArray: true
      }).success(function(data) {
        $s.books = data;
        $rs.hideLoading();
        return $s.$broadcast('scroll.refreshComplete');
      });
    };
    return $s.doRefresh();
  }
]).controller('BookDetailController', [
  '$scope', '$rootScope', '$http', '$ionicLoading', '$timeout', '$stateParams', function($s, $rs, $http, $loading, $timeout, $params) {
    $s.book = {};
    $s.getInfo = function() {
      $rs.showLoading();
      return $http({
        method: 'GET',
        url: window.ApiBaseUrl + "book.json",
        params: {
          id: $params.BookId
        },
        isArray: true
      }).success(function(data) {
        var i, j, ref, ref1, results, results1;
        $s.book = data;
        $s.rating = Math.round($s.book.rating.average / 2);
        $s.rating_up = (function() {
          results = [];
          for (var i = 0, ref = $s.rating; 0 <= ref ? i < ref : i > ref; 0 <= ref ? i++ : i--){ results.push(i); }
          return results;
        }).apply(this);
        $s.rating_down = (function() {
          results1 = [];
          for (var j = 0, ref1 = 5 - $s.rating; 0 <= ref1 ? j < ref1 : j > ref1; 0 <= ref1 ? j++ : j--){ results1.push(j); }
          return results1;
        }).apply(this);
        $s.hideLoading();
        return $s.$broadcast('scroll.refreshComplete');
      }).error(function() {
        $rs.hideLoading();
        $rs.showLoading("当前服务有问题，请稍后再试！");
        return $timeout(function() {
          return $rs.hideLoading();
        }, 1000);
      });
    };
    $s.getInfo();
  }
]).controller('BorrowController', [
  '$scope', '$rootScope', '$http', '$ionicLoading', '$timeout', '$stateParams', function($s, $rs, $http, $loading, $timeout, $params) {
    $s.info = {};
    $s.getTitle = function() {
      $rs.showLoading("请稍后...");
      return $http({
        method: 'GET',
        url: window.ApiBaseUrl + "book.json",
        params: {
          id: $params.BookId,
          attr: 'title'
        }
      }).success(function(data) {
        $s.info.title = data.result;
        return $rs.hideLoading();
      }).error(function() {
        $rs.hideLoading();
        $s.showLoading("当前网络有问题，请稍后再试！");
        return $timeout(function() {
          return $rs.hideLoading();
        }, 1000);
      });
    };
    $s.getTitle();
    $s.postApplication = function() {
      $rs.showLoading();
      return $http({
        method: "POST",
        url: window.ApiBaseUrl + "borrow/" + $params.BookId + ".json",
        data: {
          borrow: {
            target: $s.info.name,
            phone: $s.info.phone
          }
        }
      }).success(function(data) {
        $rs.hideLoading();
        if (data.status === 200) {
          $rs.showLoading("申请成功！");
        } else {
          $rs.showLoading("当前无法提交申请\n请稍后再试");
        }
        return $timeout(function() {
          return $rs.hideLoading();
        }, 1000);
      }).error(function() {
        $rs.hideLoading();
        $rs.showLoading("当前无法提交申请\n请稍后再试");
        return $timeout(function() {
          return $rs.hideLoading();
        }, 1000);
      });
    };
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
