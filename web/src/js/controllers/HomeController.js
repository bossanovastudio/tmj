tmj.controller('HomeController', function($rootScope, $scope, $http, $sce, $compile, $routeParams) {

    $scope.ready = false;
    $scope.cards = [];

    $scope.PAGE = 1;
    $scope.SIZE = 20;
    $scope.END = false;

    $scope.VIDEOS = [
        'https://www.youtube.com/watch?v=ZdBY7qEQDjc',
        'https://www.youtube.com/watch?v=F1gjyTLq2lU',
        'https://www.youtube.com/watch?v=w_Dut12rQdA',
        'https://vimeo.com/151437857',
        'https://vimeo.com/90695670',
        'https://vimeo.com/95656929'
    ]

    $http.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded";

    $scope.count = 0;

    $scope.loadCards = function(p) {
        if ($scope.PAGE > 1) {
            $('.cards').addClass('loading');
        }
        $http({
                method: 'get',
                url: API_URL + '/api/cards/' + p + '/' + $scope.SIZE + '.json',
            })
            .success(function(data) {
                if (data.cards.length == 0) {
                    $scope.END = true;
                } else {
                    $scope.cards.push({
                        id: (parseInt(Math.random() * 999999) + 1),
                        kind: 'featured',
                        url: '/img/featured_background.png',
                        size: ['four', 'five', 'four', 'five', 'four', 'five', 'four', 'five', 'four', 'five', 'four', 'five', 'four', 'five', 'four', 'five', 'four', 'five', 'four', 'five', 'four', 'five', 'four', 'five', 'four', 'five', 'four', 'five', 'four', 'five', 'four'][$scope.count++],
                        content: 'Seja sua própria heroína. Somos todas #donasdarua'
                    });
                    $scope.cards.push({
                        id: (parseInt(Math.random() * 999999) + 1),
                        kind: 'video',
                        url: $scope.VIDEOS[3],
                        content: 'Seja sua própria heroína. Somos todas #donasdarua',
                        size: 'two',
                        posted_at: '2016-11-03T12:38:43.000Z'
                    });
                    data.cards.forEach(function(card) {
                        $scope.cards.push(card);
                    });
                    $scope.ready = true;
                    if (!isMobileDevice) {
                        setTimeout(function() {
                            if ($('.cards').data('masonry')) {
                                $('.cards').masonry('reloadItems');
                                $('.cards').masonry();
                            } else {
                                $('.cards').masonry({
                                    itemSelector: '.card',
                                    columnWidth: '.one-five',
                                    percentPosition: true,
                                    gutter: 0,
                                    transitionDuration: 0
                                });
                            }
                        }, 1000);
                    } else {
                        if ($('.cards').data('masonry')) {
                            $('.cards').masonry('destroy');
                        }
                    }
                    if ($scope.PAGE == 1) {
                        setTimeout(function() {
                            if ($('.initial-loading').is(':visible')) {
                                $('.initial-loading').hide();
                            }
                            $('.cards').find('.card').addClass('show');
                        }, 1000);
                    } else {
                        setTimeout(function() {
                            $('.cards').removeClass('loading');
                            $('.cards').find('.card').addClass('show');
                        }, 1000);
                    }
                }
            });
    }

    $scope.loadCards($scope.PAGE);
    $scope.currentScroll = 0;

    var distanceTop = 0;
    $scope.swipeLeft = function() {
        $scope.currentScroll = $('section').scrollLeft();
        $('section').animate({
            scrollLeft: $scope.currentScroll += $('.card').width() + 20
        }, 250);
        $scope.currentScroll = $scope.currentScroll + ($('.card').width() + 20) * 2;
        var total = $('.card').length * ($('.card').width() + 20);
        if ($scope.currentScroll == total) {
            $scope.PAGE++;
            $scope.loadCards($scope.PAGE);
        }
    }
    $scope.swipeRight = function() {
        $scope.currentScroll = $('section').scrollLeft();
        $('section').animate({
            scrollLeft: $scope.currentScroll -= $('.card').width() + 20
        }, 250);
    }
    $scope.swipeUp = function() {
        distanceTop = $(window).height();
        $('.cards').each(function() {
            var top = parseInt($(this).css('top').replace('px'));
            $(this).animate({ top: top - distanceTop });
        });
    }
    $scope.swipeDown = function() {
        distanceTop = $(window).height();
        $('.cards').each(function() {
            var top = parseInt($(this).css('top').replace('px'));
            var to = top + distanceTop;
            if (to > 0) {
                to = 0;
            }
            $(this).animate({ top: to });
        });
    }
    $scope.openCard = function($event, id, content) {
        var elem = angular.element($event.target);
        if (!elem.hasClass('arrow') && !elem.hasClass('heart') && !elem.hasClass('shareButton')) {
            $http({
                    method: 'get',
                    url: API_URL + '/api/cards/' + id + '.json',
                })
                .success(function(data) {
                    $rootScope.card = data;
                    if (isMobileDevice) {
                        var card = $(elem).closest('.card').clone();
                        card.css({
                            "position": "absolute",
                            "left": "50%",
                            "margin": 0,
                            "margin-left": card.width() / 2 * -1,
                            "top": 47,
                            "z-index": 999
                        });
                        var content = $compile(card.html())($scope);
                        card.html(content);
                        $('body').append(card);
                        card.animate({
                            left: 0,
                            top: 0,
                            margin: 0,
                            width: '100%',
                            height: '100%'
                        }, 200);

                        setTimeout(function() {
                            $('.card').last().find('.heart').attr('src', '/img/like.png').width(24);
                            $('.card').last().find('.arrow').attr('src', '/img/share.png').width(24);
                            $('.card').last().find('.read-more').remove();

                            if ($('.card').last().hasClass('text')) {
                                $('.card').last().find('.content').css({
                                    height: '100%',
                                    overflow: 'auto'
                                });
                                $('.card').last().find('.text').css({
                                    height: '85%',
                                    overflow: 'auto'
                                });
                            } else {
                                $('.card').last().find('.img, .content').animate({
                                    height: "50%"
                                }, 300);
                                $('.card').last().find('.text').css({
                                    height: '45%',
                                    overflow: 'auto'
                                });
                            }

                            $('.card').last().find('.text').text(content.content);
                            $('.card').last().find('.share').css({
                                position: 'absolute',
                                bottom: 0,
                                width: '90%',
                                'margin-bottom': 10
                            });
                            var close = $compile('<img class="close" ng-click="close($event)" src="/img/fechar.png" />')($scope);
                            $('.card').last().append(close);
                            $('.card').last().find('.close').css({
                                display: 'block'
                            });
                        }, 1);

                    } else {
                        if ($rootScope.card.content.length > 100 || $rootScope.card.kind == 'image') {
                            $('body').css({ overflow: "hidden" });
                            var lightbox = angular.element(document.querySelector('.lightbox'));
                            lightbox.fadeIn();
                        }
                    }
                });
        }
    }

    if ($routeParams.id) {
        $scope.openCard({}, $routeParams.id);
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

    $scope.textSize = !isMobileDevice ? 100 : 200;

    $scope._throttleTimer = null;
    $scope._throttleDelay = 100;

    $scope.ScrollHandler = function(e) {
        clearTimeout($scope._throttleTimer);
        $scope._throttleTimer = setTimeout(function() {
            if ($(window).scrollTop() + $(window).height() > $(document).height() - 100) {
                $scope.PAGE++;
                if (!$scope.END) {
                    $scope.loadCards($scope.PAGE);
                }
            }
        }, $scope._throttleDelay);
    }

    $(document).ready(function() {
        $(window).off('scroll', $scope.ScrollHandler).on('scroll', $scope.ScrollHandler);
    });
});
