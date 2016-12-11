var API_URL = "@@replace_api_grunt";
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
    })
    .run(function($rootScope, $location) {
        $rootScope.$on('$routeChangeSuccess', function() {
            setTimeout(function() {
                var SPMaskBehavior = function(val) {
                        return val.replace(/\D/g, '').length === 11 ? '(00) 00000-0000' : '(00) 0000-00009';
                    },
                    spOptions = {
                        onKeyPress: function(val, e, field, options) {
                            field.mask(SPMaskBehavior.apply({}, arguments), options);
                        }
                    };
                $('.phone').mask(SPMaskBehavior, spOptions);
                $('.cpf').mask('000.000.000-00');
                $('.date').mask('00/00/0000');
                $('.number').mask('#');
                $('.zip').mask('00000-000');
            }, 1);
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
