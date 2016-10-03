var organizeCards = function(newValue, oldValue) {
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
            var h = newValue.h - 280;
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
}

tmj.directive('resize', function($window) {
    return function(scope, element, attr) {
        var w = angular.element($window);
        scope.$watch(function() {
            return {
                'h': w.height(),
                'w': w.width()
            };
        }, organizeCards, true);
        w.bind('resize', function() {
            scope.$apply();
        });
    }
});

tmj.directive('organizeCards', function() {
    return function(scope, element, attrs) {
        if (scope.$last) {
            setTimeout(function() {
                var w = $(window);
                organizeCards({
                    'h': w.height(),
                    'w': w.width()
                }, {
                    'h': w.height(),
                    'w': w.width()
                })
            }, 1);
        }
    };
})
