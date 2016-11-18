tmj.controller('LoginController', function($rootScope, $scope, $http, $sce, $compile, $routeParams) {
        
    $('.initial-loading').hide(0);
    $('.purple-overlay').show();

    $scope.openPassword = function($event) {
        if ($('.pass-box').hasClass('show')){
            $('.pass-box').removeClass('show');
        } else{
            $('.pass-box').addClass('show');
        }
    }
});
