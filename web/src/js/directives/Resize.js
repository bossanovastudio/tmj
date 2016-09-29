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

                $('.card').width(newValue.w - 80);
                $('.card').eq(0).css({
                    "margin-left": 40
                });

                $('.cards').css({
                    "width": 4000,
                    "max-width": 4000,
                    "margin": 0,
                    "padding": 0
                });

                var e = $('.card').width() + 20
                var w = (e * $('.card').length) + 70;
                $('.cards').css({
                    "width": w,
                    "max-width": w
                });

                $('.card').attr('class', 'card');
                // -20 is the footer height
                var h = newValue.h - $('header').height() - ($('.card').height() - $('.card .img').height()) - 20;
                $('.card .img').height(h);
            }
        }, true);
        w.bind('resize', function() {
            scope.$apply();
        });
    }
});
