var API_URL = "@@replace_api_grunt";
var SITE_URL = window.location.protocol + '//' + window.location.host;
var isMobileDevice = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);

(function(i, s, o, g, r, a, m) {
    i['GoogleAnalyticsObject'] = r;
    i[r] = i[r] || function() {
        (i[r].q = i[r].q || []).push(arguments)
    }, i[r].l = 1 * new Date();
    a = s.createElement(o),
        m = s.getElementsByTagName(o)[0];
    a.async = 1;
    a.src = g;
    m.parentNode.insertBefore(a, m)
})(window, document, 'script', 'https://www.google-analytics.com/analytics.js', 'ga');

ga('create', 'UA-88003802-1', 'auto');

var tmj = angular.module('tmj', [
    'ngTouch',
    'ngRoute',
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'swipe',
    'ngclipboard'
]);
tmj
    .config(function($routeProvider, $locationProvider, $httpProvider) {
        $routeProvider
            .when('/', {
                templateUrl: '/pages/home.html',
                controller: 'HomeController'
            })
            .when('/personagem/ramona', {
                templateUrl: '/pages/ramona.html',
                controller: 'RamonaController'
            })
            .when('/detalhe/card/:id', {
                templateUrl: '/pages/home.html',
                controller: 'HomeController'
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
    })
    .run(['$route', '$rootScope', '$location', function($route, $rootScope, $location) {
        ga('send', 'pageview', { page: $location.url() });
        var original = $location.path;
        $rootScope.previousURL = $location.$$path;
        $location.path = function(path, reload) {
            if (reload === false) {
                var lastRoute = $route.current;
                var un = $rootScope.$on('$locationChangeSuccess', function() {
                    $route.current = lastRoute;
                    un();
                });
            }
            return original.apply($location, [path]);
        };
    }]);
