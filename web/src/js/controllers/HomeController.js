tmj.controller('HomeController', function($rootScope, $scope, $http, $sce) {
    $scope.swipeLeft = function() {
        var current = $('section').scrollLeft();
        $('section').animate({
            scrollLeft: current += $('.card').width() + 20
        }, 250);
    }
    $scope.swipeRight = function() {
        var current = $('section').scrollLeft();
        $('section').animate({
            scrollLeft: current -= $('.card').width() + 20
        }, 250);
    }
});
