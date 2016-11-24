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
    });
