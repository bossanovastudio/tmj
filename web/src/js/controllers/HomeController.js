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

    $scope.randomNumber = function() {
        return ['one', 'two', 'three', 'four', 'five', 'five'][parseInt(Math.random() * 5)];
    }

    $scope.loadCards = function(p, m) {
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
                        url: 'http://localhost:8080/img/featured_background.png',
                        size: $scope.randomNumber(),
                        content: 'I watched the storm, so beautiful yet so terrific'
                    });
                    $scope.cards.push({
                        id: (parseInt(Math.random() * 999999) + 1),
                        kind: 'video',
                        url: $scope.VIDEOS[parseInt(Math.random() * 6)],
                        content: 'I watched the storm, so beautiful yet so terrific',
                        size: 'two',
                        posted_at: '2016-11-03T12:38:43.000Z'
                    });
                    data.cards.forEach(function(card) {
                        $scope.cards.push(card);
                    });
                    $scope.ready = true;
                    if (!m) {
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
                    }
                }
            });
    }

    $scope.loadCards($scope.PAGE, false);
    $scope.currentScroll = 0;

    $scope.swipeLeft = function() {
        $scope.currentScroll = $('section').scrollLeft();
        $('section').animate({
            scrollLeft: $scope.currentScroll += $('.card').width() + 20
        }, 250);
        $scope.currentScroll = $scope.currentScroll + ($('.card').width() + 20) * 2;
        var total = $('.card').length * ($('.card').width() + 20);
        if ($scope.currentScroll == total) {
            $scope.PAGE++;
            $scope.loadCards($scope.PAGE, true);
        }
    }
    $scope.swipeRight = function() {
        $scope.currentScroll = $('section').scrollLeft();
        $('section').animate({
            scrollLeft: $scope.currentScroll -= $('.card').width() + 20
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
                        if ($rootScope.card.content.length > 200 || $rootScope.card.kind == 'image') {
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

    $scope._throttleTimer = null;
    $scope._throttleDelay = 100;

    $scope.ScrollHandler = function(e) {
        clearTimeout($scope._throttleTimer);
        $scope._throttleTimer = setTimeout(function() {
            if ($(window).scrollTop() + $(window).height() > $(document).height() - 100) {
                $scope.PAGE++;
                if (!$scope.END) {
                    $scope.loadCards($scope.PAGE, false);
                }
            }
        }, $scope._throttleDelay);
    }

    $(document).ready(function() {
        $(window).off('scroll', $scope.ScrollHandler).on('scroll', $scope.ScrollHandler);
    });
});
