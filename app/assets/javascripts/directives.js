email_app.directive("headermenu", function($location) {
  return {
    restrict: 'E',
    templateUrl: '_nav.html',
    link: function($scope, $element, $attrs) {
      $scope.$location = $location;
      $scope.$watch('$location.path()', function(locationPath) {
        var menuItems = $element.find("li");
        angular.forEach(menuItems, function(item) {
          var item = $(item);
          var link = item.find("a").attr("href").slice(1);
          if (link == locationPath) {
            item.addClass("active");
          }
          else {
            item.removeClass("active");
          }
        });
      });
    }
  };
});

email_app.directive('requireMultiple', function() {
  return {
    require: 'ngModel',
    link: function postLink(scope, element, attrs, ngModel) {
      ngModel.$validators.required = function (value) {
          return angular.isArray(value) && value.length > 0;
      };
    }
  };
});

// email_app.directive('attachments', function() {
//   return {
//     restrict: 'E',
//     templateUrl: 'assets/_attachments.html',
//     scope: {
//       attachments: '=list'
//     }
//   };
// });

// email_app.directive('notifications', function(NotificationService) {
//   return {
//     restrict: 'C',
//     templateUrl: 'assets/_notifications.html',
//     link: function (scope, element, attrs) {
//       NotificationService.getList().success(function(response) {
//         scope.notifications = response.notifications;
//         scope.unread_count = response.unread_count;
//       });
//     },
//     controller: function($scope, $element, $interval){
//       $scope.markRead = function(){
//         if ($scope.unread_count > 0) {
//           $scope.unread_count = 0;
//           NotificationService.markRead();
//         }
//       }
//       var listenNotification = function() {
//         PrivatePub.subscribe("/subscriptions/" + current_user.id, function(data, channel) {
//           if (data.notification) {
//             $scope.unread_count++;
//             $scope.notifications.unshift(data.notification);
//           }
//         });
//       }
//       $interval(listenNotification, 4000);
//     }
//   };
// })