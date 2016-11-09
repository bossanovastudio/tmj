tmj.controller('MainController', function($rootScope, $scope, $http, $sce) {
    $rootScope.API_URL = API_URL;
    $rootScope.card = {};
    $rootScope.card.posted_at = "";
    $rootScope.card.liked = false;
    $scope.openMenu = function() {
        var overlay = angular.element(document.querySelector('.overlay'));
        overlay.addClass('open');
        var sidebar = angular.element(document.querySelector('.sidebar'));
        sidebar.addClass('open');
    }
    $scope.closeMenu = function() {
        var overlay = angular.element(document.querySelector('.overlay'));
        overlay.removeClass('open');
        var sidebar = angular.element(document.querySelector('.sidebar'));
        sidebar.removeClass('open');
    }
    $scope.likeCard = function($event, id) {
        var elem = $(angular.element($event.target)).closest('.card');
        var heart = elem.find('.heart');
        if (!heart.parent().hasClass('liked')) {
            var count = parseInt(elem.find('.counter').text());
            $http({
                    method: 'GET',
                    url: API_URL + '/api/cards/' + id + '/like'
                })
                .then(function(data) {
                    heart.attr('src', '/img/liked.png');
                    count++;
                    heart.parent().find('.counter').html('&nbsp;' + count);
                    heart.parent().addClass('liked');
                }, function(data) {

                });
        }
    }
    $scope.openShare = function($event) {
        var elem = angular.element($event.target);
        var card = $(elem).closest('.content');
        $('.card').css({ "z-index": 0 });
        card.parent().css({ "z-index": 1 });
        card.find('.shareBox').fadeIn();
    }
    $("body").click(function(e) {
        if (e.target.className !== "shareBox" && e.target.className.indexOf('share') === -1 && e.target.className !== "arrow") {
            $(".shareBox").fadeOut();
        }
    });
    $scope.closeLightbox = function() {
        var lightbox = angular.element(document.querySelector('.lightbox'));
        lightbox.fadeOut();
        $('body').css({overflow: "auto"});
    }
});
