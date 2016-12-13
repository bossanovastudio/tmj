tmj.controller('MainController', function($rootScope, $scope, $http, $sce, $location) {
    $rootScope.API_URL = API_URL;
    $rootScope.track = function(action, label, value) {
        ga('send', 'event', 'User interaction', action, label);
    }
});
