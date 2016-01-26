email_app.controller 'ComposeCtrl', [
  '$scope'
  '$location'
  '$http'
  ($scope, $location, $http) ->
    $scope.send = (message, draft) ->
      message.draft = draft
      $http.post(Routes.emails_path(), message)
      $location.path(Routes.emails_path())
      return
]
email_app.controller 'InboxCtrl', [
  '$scope'
  '$http'
  ($scope, $http) ->
    $http.get(Routes.inbox_emails_path()).success (response) ->
      #console.log(response)
      $scope.emails = response.emails
]

email_app.controller 'EmailDetailsCtrl', [
  '$scope'
  '$routeParams'
  '$http'
  ($scope, $routeParams, $http) ->
    $http.get(Routes.outbox_emails_path()).success (response) ->
      $scope.emailID = $routeParams.emailID
]


email_app.controller 'OutboxCtrl', [
  '$scope'
  '$http'
  ($scope, $http) ->
    $http.get(Routes.outbox_emails_path()).success (response) ->
      #console.log(response)
      $scope.emails = response.emails
]
email_app.controller 'DrafCtrl', [
  '$scope'
  '$http'
  ($scope, $http) ->
    $http.get(Routes.draft_emails_path()).success (response) ->
      #console.log(response)
      $scope.emails = response.emails
]

email_app.controller 'ContactCtrl', [
  '$scope'
  '$http'
  ($scope, $http) ->
    $http.get(Routes.contacts_path()).success (response) ->
      #console.log(response)
      $scope.contacts = response.contacts
]


email_app.controller 'newContactCtrl', [
  '$scope'
  '$location'
  '$http'
  ($scope, $location, $http) ->
    $scope.save = (contact) ->
      $http.post(Routes.contacts_path(), contact)
      $location.path(Routes.contacts_path())
      return
]