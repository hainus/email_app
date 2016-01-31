email_app.controller('ContactsIndexController', function($scope, NgTableParams, TableService) {
  var tableParams = TableService.getTableParams(Routes.contacts_path());
  $scope.tableParams = new NgTableParams(tableParams.params, tableParams.settings);

  $scope.destroy = function destroy(id) {
    if (confirm("Are you sure you want to delete this contact?")) {
      ContactService.delete(id).success(function(response) {
        if (response.success) {
          alert("Contact is deleted successfully!");
          $scope.tableParams.reload();
        }
      });
    }
  }
});

email_app.controller('ContactsNewController', function($scope, $location) {
  $scope.save = function(contact) {
    ContactService.create(contact).success(function(response) {
      if (response.success) {
        alert("Contact is created successfully!");
        $location.path(Routes.contacts_path());
      }
    });
  }
});

email_app.controller('ContactsEditController', function($scope, $location, ContactService, response) {
  $scope.contact = response.data.contact;
  $scope.save = function(contact) {
    ContactService.update(contact.id, contact).success(function(response) {
      if (response.success) {
        alert("Contact is updated successfully!");
        $location.path(Routes.contacts_path());
      }
    });
  }
});
