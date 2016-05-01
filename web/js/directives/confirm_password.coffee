window.App.directive 'confirmPassword', [ ->
  {
    require: 'ngModel'
    link: (scope, elem, attrs, ctrl) ->
      firstPassword = '#' + attrs.confirmPassword
      elem.add(firstPassword).on 'keyup', ->
        scope.$apply ->
          valid = elem.val() is $(firstPassword).val()
          ctrl.$setValidity 'confirm_password', valid

  }
 ]