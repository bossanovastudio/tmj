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

tmj.filter('formatDate', function() {
    return function(input) {
        var year = input.substring(0, 4);
        var monthNames = ["jan", "fev", "mar", "abr", "mai", "jun",
  "jul", "ago", "set", "out", "nov", "dez"
];
        var month = input.substring(5, 7);
        var day = input.substring(8, 10);
        var hour = input.substring(11, 13);
        var minute = input.substring(14, 16);

        return day + ' ' + monthNames[month-1] + ' ' + year +', ' + hour + 'h' + minute;
    };
});
