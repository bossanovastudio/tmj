var organizeCards = function(newValue, oldValue) {
    if (newValue.w > 480) {
        $('.cards').css({
            "width": "80%",
            "max-width": "1180px",
            "margin": "0 auto",
            "padding": 0
        });
        $('.cards').find('.card').each(function() {
            //$(this).attr('class', 'card three ng-scope');
            $(this).attr('style', '');
            //$(this).find('.img').attr('style', '');
        });
        if ($('.cards').masonry()) {
            $('.cards').masonry('destroy');
        }
        $('.cards').masonry({
            itemSelector: '.card',
            columnWidth: '.one-five',
            percentPosition: true,
            gutter: 20
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
            card.attr('class', 'card ng-scope');
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

tmj.directive("cardClass", function() {
    return {
        restrict: 'EA',
        replace: false,
        scope: {
            ngClasses: "="
        },
        link: function(scope, elem, attr) {
            var card = scope.ngClasses;
            if (card.kind == 'image') {
                var ratio = parseFloat(card.image.ratio.replace(',', '.'));
                if (ratio <= 1) {
                    var percent = 50 * (1 + (1 - ratio));
                    $(elem).parent().addClass('card one-five column');
                    $(elem).css({ "padding": percent + "% 0" });
                } else {
                    var percent = 50 * (card.image.height / card.image.width);
                    $(elem).css({ "padding": percent + "% 0" });
                    if (percent > 16) {
                        $(elem).parent().addClass('card two-five column');
                    } else if (percent > 33) {
                        $(elem).parent().addClass('card three-five column');
                    } else {
                        $(elem).parent().addClass('card one-five column');
                    }
                }
            } else if (card.kind == 'text') {
                $(elem).parent().addClass('card one-five column text');
                $(elem).remove();
            }
        }
    }
});
