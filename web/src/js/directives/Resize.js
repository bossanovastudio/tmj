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
                $('.card').width(newValue.w - 100);
                var m = ((newValue.w - ($('.card').width() + 20)) / 2) + 10;
                $('.card').eq(0).css({
                    "margin-left": m
                });
                var e = $('.card').width() + 20
                var w = e * $('.card').length;
                $('.cards').css({
                    "width": w + (m * 2) + 20,
                    "max-width": w + (m * 2) + 20
                });
                $('.card').attr('class', 'card');
                var h = newValue.h - $('.card').height() + 51;
                $('.card .img').height(h);
            }
        }, true);
        w.bind('resize', function() {
            scope.$apply();
        });
    }
});
