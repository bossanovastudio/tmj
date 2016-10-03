tmj.directive('resize', function($window) {
    return function(scope, element, attr) {
        var w = angular.element($window);
        scope.$watch(function() {
            return {
                'h': w.height(),
                'w': w.width()
            };
        }, function(newValue, oldValue) {
            if (newValue.w > 480) {
                $('.cards').masonry({
                    itemSelector: '.card',
                    columnWidth: 100,
                    percentPosition: true,
                    gutter: 20,
                    percentPosition: true
                });
            } else {
                if ($('.cards').masonry()) {
                    $('.cards').masonry('destroy');
                }

                $('.cards').each(function() {
                    var card = $(this).find('.card');
                    card.width(newValue.w - 80);
                    card.eq(0).css({
                        "margin-left": 40
                    });
                    card.attr('class', 'card');
                    var h = newValue.h - $('header').height() - (card.height() - card.find('.img').height()) - 20;
                    card.find('.img').height(h);
                    var e = card.width() + 20
                    var w = (e * card.length) + 70;
                    $(this).css({
                        "width": w,
                        "max-width": w,
                        "margin": 0,
                        "padding": 0
                    });
                });
            }
        }, true);
        w.bind('resize', function() {
            scope.$apply();
        });
    }
});
