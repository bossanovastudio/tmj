var tmj = angular.module('tmj', ['ngTouch', 'ngRoute', 'ngAnimate', 'ngCookies']);
tmj
    .config(function($routeProvider, $locationProvider, $httpProvider) {
        $routeProvider
            .when('/', {
                templateUrl: '/pages/home.html',
                controller: 'HomeController'
            });

        $routeProvider
            .otherwise({
                redirectTo: "/"
            });

        $locationProvider.html5Mode(true);
    });
