var API_URL = "@@replace_api_grunt";
var isMobileDevice = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);

var tmj = angular.module('tmj', ['ngTouch', 'ngRoute', 'ngAnimate', 'ngCookies', 'ngResource', 'swipe']);
tmj.config(function($routeProvider, $locationProvider, $httpProvider) {
    $routeProvider
        .when('/', {
            templateUrl: '/pages/register.html',
            controller: 'RegisterController'
        });
    $routeProvider
        .otherwise({
            redirectTo: "/"
        });
    $locationProvider.html5Mode(true);
});
