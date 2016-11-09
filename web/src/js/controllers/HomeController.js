tmj.controller('HomeController', function($rootScope, $scope, $http, $sce, $compile) {

    $scope.ready = false;
    $scope.cards = [];

    $scope.PAGE = 1;
    $scope.END = false;

    $http.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded";

    $scope.loadCards = function(p) {
        $http({
                method: 'get',
                url: API_URL + '/api/cards/' + p + '/20.json',
            })
            .success(function(data) {
                if (data.cards.length == 0) {
                    $scope.END = true;
                } else {
                    data.cards.forEach(function(card) {
                        var id = card.id;
                        var content = card.content;
                        var origin = card.origin;
                        var media = false;
                        if (card.media) {
                            media = API_URL + card.media.file.url;
                        }
                        $scope.cards.push(card);
                    });
                    $scope.ready = true;
                }
            });
    }

    $scope.loadCards($scope.PAGE);

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
    $scope.openCard = function($event, id) {
        var elem = angular.element($event.target);
        if (!elem.hasClass('arrow') && !elem.hasClass('heart')) {
            $http({
                    method: 'get',
                    url: API_URL + '/api/cards/' + id + '.json',
                })
                .success(function(data) {
                    $rootScope.card = data;
                    if ($(window).width() < 481) {
                        var card = $(elem).closest('.card').clone();
                        card.css({
                            "position": "absolute",
                            "left": "50%",
                            "margin": 0,
                            "margin-left": card.width() / 2 * -1,
                            "top": 47,
                            "z-index": 999
                        });
                        $('body').append(card);
                        card.animate({
                            left: 0,
                            top: 0,
                            margin: 0,
                            width: '100%',
                            height: '100%'
                        }, 300);
                        card.find('.img, .content').animate({
                            height: "50%"
                        }, 300);
                        card.find('.heart').attr('src', '/img/like-copy.png').width(24);
                        card.find('.arrow').attr('src', '/img/share-copy.png').width(24);
                        card.find('.text').css({
                            height: '45%',
                            overflow: 'auto'
                        });
                        card.find('.share').css({
                            position: 'absolute',
                            bottom: 0,
                            width: '90%',
                            'margin-bottom': 10
                        });
                        var close = $compile('<img class="close" ng-click="close($event)" src="/img/fechar.png" />')($scope);
                        card.append(close);
                        card.find('.close').css({
                            display: 'block'
                        });
                    } else {
                        if ($rootScope.card.content.length > 250 || $rootScope.card.kind == 'image') {
                            $('body').css({ overflow: "hidden" });
                            var lightbox = angular.element(document.querySelector('.lightbox'));
                            lightbox.fadeIn();
                        }
                    }
                });
        }
    }

    $scope.close = function($event) {
        var elem = angular.element($event.target);
        var card = $(elem).closest('.card');
        card.fadeOut(300, function() {
            $(this).remove();
        })
    }

    $scope.likeCard = function($event, id) {
        var elem = $(angular.element($event.target)).closest('.card');
        var heart = elem.find('.heart');
        if (!heart.parent().hasClass('liked')) {
            var count = parseInt(elem.find('.counter').text());
            $http({
                    method: 'POST',
                    url: API_URL + '/api/cards/' + id + '/like',
                    data: $.param({
                        id: id
                    })
                })
                .then(function(data) {
                    heart.attr('src', '/img/liked.png');
                    count++;
                    heart.parent().find('.counter').html('&nbsp;' + count);
                    heart.parent().addClass('liked');
                }, function(data) {
                    //remove that and parse error
                    heart.attr('src', '/img/liked.png');
                    count++;
                    heart.parent().find('.counter').html('&nbsp;' + count);
                    heart.parent().addClass('liked');
                });
        }
    }
    $scope.openShare = function($event) {
        var elem = angular.element($event.target);
        var card = $(elem).closest('.card');
        $(".shareBox").stop(true, true).fadeOut(100, function() {
            $('.card').css({ "z-index": 0 });
            card.css({ "z-index": 1 });
            card.find('.shareBox').stop(true, true).fadeIn(200);
        });
    }
    $("body").click(function(e) {
        if (e.target.className !== "shareBox" && e.target.className.indexOf('share') === -1 && e.target.className !== "arrow") {
            $(".shareBox").fadeOut(200);
        }
    });

    $scope._throttleTimer = null;
    $scope._throttleDelay = 100;

    $scope.ScrollHandler = function(e) {
        clearTimeout($scope._throttleTimer);
        $scope._throttleTimer = setTimeout(function() {
            if ($(window).scrollTop() + $(window).height() > $(document).height() - 100) {
                $scope.PAGE++;
                if (!$scope.END) {
                    $scope.pageHeight();
                    $scope.loadCards($scope.PAGE);
                }
            }
        }, $scope._throttleDelay);
    }

    $scope.pageHeight = function() {
        $('section').height($('.cards').height());
    }

    $(document).ready(function() {
        $(window).off('scroll', $scope.ScrollHandler).on('scroll', $scope.ScrollHandler);
    });
});
