tmj.controller('HomeController', function($rootScope, $scope, $http, $sce, $compile) {

    $scope.ready = false;
    $scope.cards = [];
    $http({
            method: 'get',
            url: API_URL + '/api/cards.json',
        })
        .success(function(data) {
            data.forEach(function(card) {
                var id = card.id;
                var content = card.content;
                var origin = card.origin;
                var media = false;
                if (card.media) {
                    media = API_URL + card.media.file.url;
                }
                $scope.cards.push({
                    id: id,
                    content: content,
                    origin: origin,
                    media: media
                });
            });
            $scope.ready = true;
        });

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
        if (!elem.hasClass('arrow') && !elem.hasClass('heart') && $(window).width() < 481) {
            $http({
                    method: 'get',
                    url: API_URL + '/api/cards/' + id + '.json',
                })
                .success(function(data) {
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
                });
        } else {
            console.log('share', id);
        }
    }
    $scope.close = function($event) {
        var elem = angular.element($event.target);
        var card = $(elem).closest('.card');
        card.fadeOut(300, function() {
            $(this).remove();
        })
    }
    $scope.classes = [
        'card one-five column',
        'card two-five column',
        'card three-five column',
        // 'card four-five column',
        // 'card five-five column',
    ]
});
