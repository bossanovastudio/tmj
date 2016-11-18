var API_URL = "@@replace_api_grunt";
var SITE_URL = window.location.protocol + '//' + window.location.host;
var isMobileDevice = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);

var tmj = angular.module('tmj', ['ngTouch', 'ngRoute', 'ngAnimate', 'ngCookies', 'ngResource', 'swipe']);
tmj
    .config(function($routeProvider, $locationProvider, $httpProvider) {
        $routeProvider
            .when('/', {
                templateUrl: '/pages/home.html',
                controller: 'HomeController'
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
    .run(['$route', '$rootScope', '$location', function ($route, $rootScope, $location) {
        var original = $location.path;
        $rootScope.previousURL = $location.$$path;
        $location.path = function (path, reload) {
            if (reload === false) {
                var lastRoute = $route.current;
                var un = $rootScope.$on('$locationChangeSuccess', function () {
                    $route.current = lastRoute;
                    un();
                });
            }
            return original.apply($location, [path]);
        };
    }]);

tmj.filter('cropText', function() {
    return function(card) {
        if (card.content !== null) {
            var maxLength = 0;
            if (card.kind == 'text') {
                maxLength = $(window).width() > 480 ? 100 : 300
            } else {
                maxLength = $(window).width() > 480 ? 100 : 200;
            }
            var trimmedString = card.content.substr(0, maxLength);
            if (trimmedString.length == card.content.length) {
                return card.content;
            }
            return trimmedString.substr(0, Math.min(trimmedString.length, trimmedString.lastIndexOf(" "))) + ' ...';
        }
    };
});

tmj.filter('formatDate', function() {
    return function(input) {
        if (!input) {
            return '';
        }
        var year = input.substring(0, 4);
        var monthNames = ["jan", "fev", "mar", "abr", "mai", "jun",
            "jul", "ago", "set", "out", "nov", "dez"
        ];
        var month = input.substring(5, 7);
        var day = input.substring(8, 10);
        var hour = input.substring(11, 13);
        var minute = input.substring(14, 16);

        return day + ' ' + monthNames[month - 1] + ' ' + year + ', ' + hour + 'h' + minute;
    };
});

tmj.filter('formatVideo', function() {
    return function(input) {
        if (!input) {
            return '';
        }
        var url = input;
        url.match(/(http:|https:|)\/\/(player.|www.)?(vimeo\.com|youtu(be\.com|\.be|be\.googleapis\.com))\/(video\/|embed\/|watch\?v=|v\/)?([A-Za-z0-9._%-]*)(\&\S+)?/);
        if (RegExp.$3.indexOf('youtu') > -1) {
            url = 'https://www.youtube.com/embed/' + RegExp.$6;
        } else if (RegExp.$3.indexOf('vimeo') > -1) {
            url = 'https://player.vimeo.com/video/' + RegExp.$6;
        }
        return '<iframe src="' + url + '" frameborder="0" allowfullscreen></iframe>';
    };
});

tmj.filter("trust", ['$sce', function($sce) {
    return function(htmlCode) {
        return $sce.trustAsHtml(htmlCode);
    }
}]);
