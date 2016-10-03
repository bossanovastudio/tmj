tmj.controller('HomeController', function($rootScope, $scope, $http, $sce, $compile) {
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
                    url: '/pages/card.json?id=' + id,
                })
                .success(function(data) {
                    console.log(data);
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
            console.log('open', id);
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
});
