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
  'Upload'
  ($scope, $location, $http, Upload) ->
    $scope.contacts = []
    $scope.receivers = {
      receivers: []
    };
    $http.get(Routes.contacts_path()).success (response) ->
      $scope.contacts = response.contacts

    $scope.send = (message, draft) ->
      receiversEmails = []
      receivers = $scope.receivers.receivers
      if receivers.length > 0
        receiversEmails = _.map receivers,  (receiver) ->
          return receiver.email
      message.draft = draft
      message.file = $scope.attachments
      message.email = receiversEmails

      Upload.upload(
        url: 'emails.json'
        data: message).then (response) ->
          $location.path(Routes.emails_path())
        return
      return
]

email_app.controller 'InboxCtrl', [
  '$scope'
  '$http'
  '$interval'
  ($scope, $http, $interval) ->
    mail_box = ->
      $http.get(Routes.inbox_emails_path()).success (response) ->
        $scope.emails = response.emails
        $scope.orderProp = 'sender_email'
    mail_box()
    $interval(mail_box, 10000);
    $scope.destroy = (id) ->
      if confirm('Are you sure you want to delete this email?')
        $http.delete(Routes.email_path({id: id})).success (response) ->
          $http.get(Routes.emails_path()).success (response) ->
            $scope.emails = response.emails
            console.log(response.emails)

]

email_app.controller 'deleteEmailCtrl', [
  '$scope'
  '$location'
  '$http'
  ($scope, $location, $http) ->
    $scope.save = (email) ->
      $http.post(Routes.emails_path(), email)
      $location.path(Routes.email_path())
      return

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
      $scope.orderProp = 'receiver_email'
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
      $scope.orderProp = 'name';
    $scope.destroy = (id) ->
      if confirm('Are you sure you want to delete this contact?')
        $http.delete(Routes.contact_path({id: id})).success (response) ->
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

email_app.controller 'editContactCtrl', [
  '$scope'
  '$routeParams'
  '$http'
  '$location'
  ($scope, $routeParams, $http, $location) ->
    $http.get(Routes.edit_contact_path({id: $routeParams.id})).success (response) ->
      $scope.contact = response.contact

    $scope.saveContact = (contact) ->
      $http.put(Routes.contact_path({id: $routeParams.id}), contact)
      $location.path(Routes.contacts_path())
      return

]

email_app.controller 'deleteContactCtrl', [
  '$scope'
  '$location'
  '$http'
  ($scope, $location, $http) ->
    $scope.save = (contact) ->
      $http.post(Routes.contacts_path(), contact)
      $location.path(Routes.contact_path())
      return
]

