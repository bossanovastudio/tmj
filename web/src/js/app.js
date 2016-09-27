var tmj = angular.module('tmj', ['ngTouch', 'ngRoute', 'ngAnimate', 'ngCookies']);

tmj.config(function($routeProvider, $locationProvider, $httpProvider) {

        $routeProvider
            .when('/', {
                templateUrl: '/pages/home.html',
                controller: 'HomeController'
            })
            .when('/login', {
                templateUrl: '/pages/home.html',
                controller: 'HomeController'
            });

        $routeProvider
            .otherwise({
                redirectTo: "/"
            });

        $locationProvider.html5Mode(true);
    })
    .run(function($rootScope, $location) {
        $rootScope.$on('$routeChangeStart', function() {
            var overlay = angular.element( document.querySelector( '.overlay' ) );
            overlay.removeClass('open');
            var sidebar = angular.element( document.querySelector( '.sidebar' ) );
            sidebar.removeClass('open');
        })
    });
