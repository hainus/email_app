
underscore = angular.module('underscore', [])
underscore.factory '_', [
  '$window'
  ($window) ->
    $window._
]


@email_app = angular.module('email_app', ['ngResource', 'ngRoute', 'ngTable', 'underscore', 'ui.select', 'ngSanitize', 'angularUtils.directives.dirPagination'])

# Sets up routing
email_app.config(['$routeProvider', ($routeProvider) ->
 	$routeProvider.
  when('/login', {
    templateUrl: 'auth/_login.html',
    controller: 'AuthCtrl'
  }).
  when('/register', {
    templateUrl: 'auth/_register.html',
    controller: 'AuthCtrl'
  }).
  when('/compose', {
    templateUrl: '/assets/compose.html',
    controller: 'ComposeCtrl'
  }).
  when('/contacts', {
    templateUrl: '/assets/contacts/index.html',
    controller: 'ContactCtrl'
  }).
  when('/contacts/new', {
    templateUrl: '/assets/contacts/form.html',
    controller: 'newContactCtrl'
  }).
  when('/contacts/:id/edit', {
    templateUrl: '/assets/contacts/form.html',
    controller: 'editContactCtrl'
  }).
  when('/drafts', {
    templateUrl: '/assets/drafts.html',
    controller: 'DrafCtrl'
  }).
  when('/inbox', {
    templateUrl: '/assets/inbox.html',
    controller: 'InboxCtrl'
  }).
  when('/email_detail/:emailID', {
    templateUrl: '/assets/email_details.html',
    controller: 'EmailDetailsCtrl'
  }).
  when('/outbox', {
    templateUrl: '/assets/outbox.html',
    controller: 'OutboxCtrl'
  }).
  when('/notifications', {
    templateUrl: '/assets/notifications.html',
    controller: 'NotificationCtrl'
  }).
  otherwise({ redirectTo: '/inbox' } )

])



