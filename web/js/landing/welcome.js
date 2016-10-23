var App = angular.module('SignUp', [])


App.controller('SignUpCtrl', [
  '$scope',
  '$http',
  function ($scope, $http) {
    $scope.user = {}

    console.log('SignUpCtrl')

    $scope.signup = function (user) {
      $http.post('/users', user)
      .then(function (resp) {
        $.jStorage.set('auth_token', resp.data.token)
        window.location.assign('/app')
      })
      .catch(function (err) {
        alert('Unable to save your data. Please try again.')
      })
    }
  }
])

App.directive('pwCheck', [function () {
    return {
      require: 'ngModel',
      link: function (scope, elem, attrs, ctrl) {
        var firstPassword = '#' + attrs.pwCheck;
        elem.add(firstPassword).on('keyup', function () {
          scope.$apply(function () {
            var v = elem.val()===$(firstPassword).val();
            ctrl.$setValidity('pwmatch', v);
          });
        });
      }
    }
  }]);