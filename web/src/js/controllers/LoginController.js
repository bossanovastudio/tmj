tmj.controller('LoginController', function($rootScope, $scope, $http, $sce, $compile, $routeParams) {
        
    $('.initial-loading').hide(0);
    $('.purple-overlay').show();

    $scope.openPassword = function($event) {
        $('.pass-box').addClass('show');
    }
});
