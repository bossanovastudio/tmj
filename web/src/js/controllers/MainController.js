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
        mobile.attr('src', '/img/fechar-mobile.svg');
        var sidebar = angular.element(document.querySelector('.sidebar'));
        sidebar.addClass('open');
        var html = angular.element(document.querySelector('html'));
        html.css({ 'overflow': 'hidden' });
    }
    $scope.closeMenu = function() {
        var overlay = angular.element(document.querySelector('.overlay'));
        overlay.removeClass('open');
        var desktop = angular.element(document.querySelector('.desktop'));
        desktop.attr('src', '/img/menu-desktop.svg');
        var mobile = angular.element(document.querySelector('.mobile'));
        mobile.attr('src', '/img/menu-mobile.svg');
        var sidebar = angular.element(document.querySelector('.sidebar'));
        sidebar.removeClass('open');
        var html = angular.element(document.querySelector('html'));
        html.css({ 'overflow': 'auto' });
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

        if (card.length > 0 && card.find('.shareBox').hasClass('show')) {
            card.find('.shareBox').removeClass('show');
            setTimeout(function() {
                card.find('.shareBox').hide();
            }, 300);
        } else if (card.length == 0 && $('.lightbox .shareBox').hasClass('show')) {
            $('.lightbox .shareBox').removeClass('show');
            setTimeout(function() {
                $('.lightbox .shareBox').hide();
            }, 300);
        } else {
            $(".shareBox").removeClass('show');
            $(".shareBox").hide();
            setTimeout(function() {
                $('.card').css({ "z-index": 0 });
                if (card.length > 0) {
                    card.find('.shareBox').show();
                    card.css({ "z-index": 999 });
                    card.find('.shareBox').addClass('show');
                } else {
                    $('.lightbox .shareBox').show();
                    $('.lightbox .shareBox').addClass('show');
                }
            }, 100)
        }
    }

    $("body").click(function(e) {
        if (e.target.className !== "shareBox" && e.target.className.indexOf('share') === -1 && e.target.className !== "arrow") {
            $(".shareBox").removeClass('show');
            setTimeout(function() {
                $(".shareBox").hide();
            }, 300);
        }
    });
    $scope.closeLightbox = function() {
        $('.lightbox').fadeOut();
        $('body').css({ overflow: "auto" });
    }
    $scope.closeLightboxClick = function($event) {
        var e = angular.element($event.target);
        e = $(e);
        if (!e.hasClass('preview') && !e.hasClass('detail') && !e.hasClass('share') && !e.hasClass('arrow')) {
            $scope.closeLightbox();
        }
    }
    $scope.closeLightboxKey = function(keyCode) {
        console.log(keyCode);
        if (parseInt(keyCode) == 27) {
            $scope.closeLightbox();
        }
    }
});
