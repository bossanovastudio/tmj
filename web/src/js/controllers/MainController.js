tmj.controller('MainController', function($rootScope, $scope, $http, $sce, $location) {
    $rootScope.API_URL = API_URL;
    $rootScope.SITE_URL = SITE_URL;
    $rootScope.card = {};
    $rootScope.card.posted_at = "";
    $rootScope.card.liked = false;
    var toggled;

    $rootScope.pageName = 'homePage';

    $rootScope.track = function(action, label, value) {
        console.log(action, label, value);
        ga('send', {
            hitType: 'event',
            eventCategory: 'User interaction',
            eventAction: action,
            eventLabel: label,
            eventValue: value,
            hitCallback: function() {
                console.log('tracked', action, label, value);
            }
        });
    }

    $scope.toggle = function() {
        $("#menu").toggleClass('open');
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
        $(".sidebar li").each(function(i) {
            var t = $(this);
            setTimeout(function() { t.addClass('animate'); }, (i + 1) * 50);
        });
        $rootScope.track('click', 'menu', 'open');
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
        setTimeout(function() {
            $(".sidebar li").removeClass("animate")
        }, 500);
        $rootScope.track('click', 'menu', 'close');
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
        $rootScope.track('click', 'card', 'like');
    }
    $scope.openShare = function($event) {
        var elem = angular.element($event.target);
        var card = $(elem).closest('.card');

        if (card.length > 0 && card.find('.shareBox').hasClass('show')) {
            card.find('.shareBox').removeClass('show');
            $('.shareBox a').removeClass('animate');
            setTimeout(function() {
                card.find('.shareBox').hide();
            }, 300);
        } else if (card.length == 0 && $('.lightbox .shareBox').hasClass('show')) {
            $('.lightbox .shareBox').removeClass('show');
            $('.shareBox a').removeClass('animate');
            setTimeout(function() {
                $('.lightbox .shareBox').hide();
            }, 300);
        } else {
            $(".shareBox").removeClass('show');
            $('.shareBox a').removeClass('animate');
            $(".shareBox").hide();
            setTimeout(function() {
                $('.card').css({ "z-index": 0 });
                if (card.length > 0) {
                    card.find('.shareBox').show();
                    card.css({ "z-index": 9 });
                    card.find('.shareBox').addClass('show');
                    card.find('.shareBox a').each(function(i) {
                        var t = $(this);
                        setTimeout(function() { t.addClass('animate'); }, (i + 1) * 50);
                    });
                } else {
                    $('.lightbox .shareBox').show();
                    $('.lightbox .shareBox').addClass('show');
                    $('.shareBox a').each(function(i) {
                        var t = $(this);
                        setTimeout(function() { t.addClass('animate'); }, (i + 1) * 50);
                    });
                }
            }, 100)
        }
        $rootScope.track('click', 'card', 'share');
    }

    $(".sidebar ul li").on('click', function() {
        $scope.closeMenu();
        $scope.toggle();
        $rootScope.track('click', 'menu', 'close');
    })

    $("body").click(function(e) {
        if (e.target.className !== "shareBox" && e.target.className.indexOf('share') === -1 && e.target.className !== "arrow") {
            $(".shareBox").removeClass('show');
            $('.shareBox a').removeClass('animate');
            setTimeout(function() {
                $(".shareBox").hide();
            }, 200);
        }
    });
    $scope.closeLightbox = function() {
        $location.path($rootScope.previousURL, false);
        $('.close').addClass('pow');
        $('.close .active').addClass('pow');
        $('.close .link').addClass('pow');
        $('.close .close-icon4').addClass('pow');
        setTimeout(function(){
            if ($(".lightbox").hasClass("show")) {
                setTimeout(function() {
                    $('lightbox').css({ "display": "none" });
                    $('body').css({ overflow: "auto" });
                    $('html').css({ overflow: "auto" });
                    $('.lightbox').removeClass("hide");
                    $('.lightbox .detail').removeClass("hide");
                }, 300);
                $('.lightbox').removeClass("show");
                $('.lightbox .detail').removeClass("show");
                $('.lightbox').addClass("hide");
                $('.lightbox .detail').addClass("hide");
            }
        },300);
        setTimeout(function(){
            $('.close').removeClass('pow');
            $('.close .active').removeClass('pow');
            $('.close .link').removeClass('pow');
            $('.close .close-icon4').removeClass('pow');
        },500);
        $rootScope.track('click', 'lightbox', 'close');
    }
    $scope.closeLightboxClick = function($event) {
        var e = angular.element($event.target);
        e = $(e);
        if (!e.hasClass('preview') && !e.hasClass('detail') && !e.hasClass('share') && !e.hasClass('arrow') && !e.hasClass('content')) {
            $scope.closeLightbox();
        }
    }
    $scope.closeLightboxKey = function(keyCode) {
        if (parseInt(keyCode) == 27) {
            $scope.closeLightbox();
        }
    }

});
