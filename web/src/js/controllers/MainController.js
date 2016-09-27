tmj.controller('MainController', function($rootScope, $scope, $http, $sce) {
    $scope.openMenu = function() {
        var overlay = angular.element( document.querySelector( '.overlay' ) );
        overlay.addClass('open');
        var sidebar = angular.element( document.querySelector( '.sidebar' ) );
        sidebar.addClass('open');
    }
    $scope.closeMenu = function() {
        var overlay = angular.element( document.querySelector( '.overlay' ) );
        overlay.removeClass('open');
        var sidebar = angular.element( document.querySelector( '.sidebar' ) );
        sidebar.removeClass('open');
    }
});
