email_app.directive('noti', function($http) {
  return {
    restrict: 'E',
    templateUrl: 'assets/notifications.html',
    link: function (scope, element, attrs) {
      $http.get(Routes.notifications_path()).success(function(response) {
        scope.notifications = response.notifications;
        scope.count_no_read = response.count_no_read;
      });
    },
    controller: function($scope, $element) {
      $scope.updateRead = function(){
        $scope.count_no_read = 0;
        $http.put(Routes.update_all_read_notifications_path());
      }
    }
  };
});