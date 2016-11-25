tmj.controller('RamonaController', function($rootScope, $scope, $http, $sce, $compile, $routeParams) {

    $rootScope.pageName = 'ramonaPage';

    var distanceTop = 0;
    $scope.swipeUp = function() {
        distanceTop = -$(window).height();
        $('.cards').each(function(i, e) {
            var top = parseInt($(this).css('top').replace('px'));
            if (i == 0 && top == (($('.cards').length - 1) * distanceTop)) {
                distanceTop = 0;
            }
            $(this).animate({ top: top + distanceTop });
        });
    }

    setTimeout(function() {
        $('.social-editor li').each(function(i){
            var t = $(this);
            setTimeout(function(){ t.addClass('animate'); }, (i+1) * 50);
        });
    }, 1000);

});
