tmj.controller('MainController', function($rootScope, $scope, $http, $sce) {
    $rootScope.API_URL = API_URL;
    $rootScope.SITE_URL = SITE_URL;
    $rootScope.card = {};
    $rootScope.card.posted_at = "";
    $rootScope.card.liked = false;
    var toggled;
    $scope.toggle = function() {
        $scope[toggled ? "closeMenu" : "openMenu"]();
        toggled = !toggled;
    };
    $scope.openMenu = function() {
        var overlay = angular.element(document.querySelector('.overlay'));
        overlay.addClass('open');
        var desktop = angular.element(document.querySelector('.desktop'));
        desktop.attr('src', '/img/fechar-desktop.svg');
        var mobile = angular.element(document.querySelector('.mobile'));
        mobile.attr('src', '/img/fechar-mobile.png');
        var sidebar = angular.element(document.querySelector('.sidebar'));
        sidebar.addClass('open');
        var html = angular.element(document.querySelector('html'));
        html.css({'overflow':'hidden'});
    }
    $scope.closeMenu = function() {
        var overlay = angular.element(document.querySelector('.overlay'));
        overlay.removeClass('open');
        var desktop = angular.element(document.querySelector('.desktop'));
        desktop.attr('src', '/img/menu-desktop.svg');
        var mobile = angular.element(document.querySelector('.mobile'));
        mobile.attr('src', '/img/menu-mobile.png');
        var sidebar = angular.element(document.querySelector('.sidebar'));
        sidebar.removeClass('open');
        var html = angular.element(document.querySelector('html'));
        html.css({'overflow':'auto'});
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
        var card = $(elem).closest('.card');

        if( card.length > 0 && card.find('.shareBox').is(':visible')) {
            card.find('.shareBox').fadeOut(200);
        } else if( card.length == 0 && $('.lightbox .shareBox').is(':visible') ) {
            $('.lightbox .shareBox').fadeOut(200);
        } else {
            $(".shareBox").stop(true, true).fadeOut(100, function() {
                $('.card').css({ "z-index": 0 });
                if( card.length > 0 ) {
                    card.css({ "z-index": 1 });
                    card.find('.shareBox').stop(true, true).fadeIn(200);
                } else {
                    $('.lightbox .shareBox').stop(true, true).fadeIn(200);
                }
            });
        }
    }

    $("body").click(function(e) {
        if (e.target.className !== "shareBox" && e.target.className.indexOf('share') === -1 && e.target.className !== "arrow") {
            $(".shareBox").fadeOut(200);
        }
    });
    $scope.closeLightbox = function() {
        var lightbox = angular.element(document.querySelector('.lightbox'));
        lightbox.fadeOut();
        $('body').css({overflow: "auto"});
    }
});
