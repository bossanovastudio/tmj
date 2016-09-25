tmj.controller('HomeController', function($rootScope, $scope, $http, $sce) {
    $('.cards').masonry({
        itemSelector: '.card',
        columnWidth: 100,
        percentPosition: true,
        gutter: 24,
        percentPosition: true
    });
});
