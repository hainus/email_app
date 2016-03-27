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