var API_URL = 'http://' + window.location.hostname + ':3000';

var tmj = angular.module('tmj', ['ngTouch', 'ngRoute', 'ngAnimate', 'ngCookies']);
tmj
    .config(function($routeProvider, $locationProvider, $httpProvider) {
        $routeProvider
            .when('/', {
                templateUrl: '/pages/home.html',
                controller: 'HomeController'
            })
            .when('/get-card/:id', {
                templateUrl: '/pages/card.json',
                controller: 'CardController'
            })
            .when('/login', {
                templateUrl: '/pages/login.html',
                controller: 'LoginController'
            });

        $routeProvider
            .otherwise({
                redirectTo: "/"
            });

        $locationProvider.html5Mode(true);
    })
    .run(function($rootScope, $location) {
        $rootScope.$on('$routeChangeStart', function() {
            var overlay = $('.overlay');
            overlay.removeClass('open');
            var sidebar = $('.sidebar');
            sidebar.removeClass('open');
        })
    });

tmj.filter('cropText', function() {
    return function(input) {
        var maxLength = 250;
        var trimmedString = input.substr(0, maxLength);
        if (trimmedString.length == input.length) {
            return input;
        }
        return trimmedString.substr(0, Math.min(trimmedString.length, trimmedString.lastIndexOf(" "))) + ' ...';
    };
});
