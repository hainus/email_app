email_app.directive 'fileModel', [
  '$parse'
  ($parse) ->
    {
      restrict: 'A'
      link: (scope, element, attrs) ->
        model = $parse(attrs.fileModel)
        modelSetter = model.assign
        element.bind 'change', ->
          scope.$apply ->
            modelSetter scope, element[0].files[0]
            return
          return
        return
    }
]

email_app.controller 'ComposeCtrl', [
  '$scope'
  '$location'
  '$http'
  ($scope, $location, $http) ->
    $scope.contacts = []
    $scope.receivers = {
      receivers: []
    };
    $http.get(Routes.contacts_path()).success (response) ->
      $scope.contacts = response.contacts

    $scope.send = (message, draft) ->
      message.draft = draft
      file = $scope.myFile;
      fd = new FormData()
      fd.append('file', file)
      fd.append('subject', message.subject)
      fd.append('content', message.content)
      fd.append('draft', draft)
      fd.append('email', $scope.receivers.receivers[0].email)

      $http.post(Routes.emails_path(), fd, {transformRequest: angular.identity, headers: {'Content-Type': undefined}})
      $location.path(Routes.emails_path())
      return
]

email_app.controller 'InboxCtrl', [
  '$scope'
  '$http'
  ($scope, $http) ->
    $http.get(Routes.inbox_emails_path()).success (response) ->
      $scope.emails = response.emails
]

email_app.controller 'EmailDetailsCtrl', [
  '$scope'
  '$routeParams'
  '$http'
  ($scope, $routeParams, $http) ->
    $http.get(Routes.detail_emails_path() + "?id=" + $routeParams.emailID).success (response) ->
      $scope.email = response.email
]


email_app.controller 'OutboxCtrl', [
  '$scope'
  '$http'
  ($scope, $http) ->
    $http.get(Routes.outbox_emails_path()).success (response) ->
      $scope.emails = response.emails
]

email_app.controller 'DrafCtrl', [
  '$scope'
  '$http'
  ($scope, $http) ->
    $http.get(Routes.draft_emails_path()).success (response) ->
      $scope.emails = response.emails
]

email_app.controller 'ContactCtrl', [
  '$scope'
  '$http'
  ($scope, $http) ->
    $http.get(Routes.contacts_path()).success (response) ->
      $scope.contacts = response.contacts
]


email_app.controller 'newContactCtrl', [
  '$scope'
  '$location'
  '$http'
  ($scope, $location, $http) ->
    $scope.saveContact = (contact) ->
      $http.post(Routes.contacts_path(), contact)
      $location.path(Routes.contacts_path())
      return
]