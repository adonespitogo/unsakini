$(window).ready ->
  token = $.jStorage.get('auth_token')
  if !token
    window.location.assign '/'
  else
    $.get('/auth/verify?token=' + token).done ->
      angular.bootstrap document, [ 'unsakini' ]
    .fail ->
      window.location.assign '/'