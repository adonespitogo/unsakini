window.App.controller 'ProfileCtrl', [
  '$scope'
  'UserService'
  '$rootScope'
  'toastr'
  ($scope, UserService, $rootScope, toastr) ->

    UserService.get().then (resp) ->
      $scope.user = resp.data

    @submit = ->
      UserService.update($scope.user)
      .then (resp) ->
        $rootScope.current_user = resp.data
        delete $scope.user.old_password
        delete $scope.user.new_password
        delete $scope.user.confirm_password
        toastr.success 'Profile updated successfully.'

      .catch (resp) ->
        $scope.user = angular.copy($rootScope.current_user)
        for err in resp.data
          toastr.error(err.message)

    return
]