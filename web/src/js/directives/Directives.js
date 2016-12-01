var organizeCards = function(newValue, oldValue, rs) {
    if (!isMobileDevice) {
        $('.cards').css({
            "width": "80%",
            "max-width": "1180px",
            "margin": "0 auto 50px auto",
            "padding": 0
        });
        $('html').css({ overflow: 'auto' });
    } else if (isMobileDevice) {
        if ($('.cards').data('masonry')) {
            $('.cards').masonry('destroy');
        }
        $('.cards').each(function(i, e) {
            var card = $(this).find('.card');
            card.width(newValue.w - 80);
            card.eq(0).css({
                "margin-left": 40
            });
            var h = newValue.h - 260;
            card.find('.img').css({ "height": h });
            card.each(function(i, c) {
                var hasClass = $(c).hasClass('ramona');
                var hasEditor = $(c).hasClass('editor');
                if ($(c).hasClass('featured')) {
                    $(c).css({ "height": newValue.h - 100 });
                } else if ($(c).hasClass('initial')) {
                    $(c).css({ "height": '100%' });
                }
                if ($(c).hasClass('featured')) {
                    $(c).attr('class', 'card featured ng-scope');
                } else if ($(c).hasClass('initial')) {
                    $(c).attr('class', 'card initial ng-scope');
                } else if ($(c).hasClass('video')) {
                    $(c).attr('class', 'card video ng-scope');
                    //$(c).find('.img').css({ "height": 0 });
                } else if ($(c).hasClass('text')) {
                    $(c).attr('class', 'card text ng-scope');
                } else {
                    $(c).attr('class', 'card cursor ng-scope');
                }
                if(hasClass && rs == 'homePage') {
                  $(c).addClass('ramona');
                }
                if(hasEditor) {
                  $(c).addClass('editor');
                }
            });
            card.find('.img').addClass('no-padding');
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

tmj.directive('resize', function($window, $rootScope) {
    return function(scope, element, attr) {
        var w = angular.element($window);
        scope.$watch(function() {
            return {
                'h': w.height(),
                'w': w.width(),
                'rs': $rootScope.pageName
            };
        }, organizeCards, true);
        w.bind('resize', function() {
            scope.$apply();
        });
    }
});

tmj.directive('organizeCards', function($rootScope) {
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
                }, $rootScope.pageName);
            }, 1);
        }
    };
})

tmj.directive("cardClass", function($rootScope) {
    return {
        restrict: 'EA',
        replace: false,
        scope: {
            ngClasses: "="
        },
        link: function(scope, elem, attr) {
            var card = scope.ngClasses;
            var maxLength = 0;
            if (card.kind == 'text') {
                maxLength = !isMobileDevice ? 300 : 299;
            } else {
                maxLength = !isMobileDevice ? 100 : 70;
            }
            if (card.content) {
                if (card.content.length > maxLength || card.kind !== 'text') {
                    $(elem).parent().addClass('cursor');
                } else {
                    $(elem).parent().removeClass('cursor');
                }
            }
            if (card.user && card.user.role == 'editor') {
                if((isMobileDevice && $rootScope.pageName == 'homePage') || (!isMobileDevice && $rootScope.pageName == 'homePage')) {
                  $(elem).parent().addClass(card.user.username);
                }
                $(elem).parent().addClass(card.user.role);
            }
            if (card.kind == 'image') {
                var ratio = parseFloat(card.image.ratio.replace(',', '.'));
                if (ratio <= 1) {
                    var percent = 50 * (1 + (1 - ratio));
                    $(elem).parent().addClass('card one-five cursor column');
                    $(elem).parent().attr('data-class', 'card one-five cursor column');
                    $(elem).css({ "padding": percent + "% 0" });
                    $(elem).attr('data-padding', percent + "% 0");
                } else {
                    var percent = 50 * (card.image.height / card.image.width);
                    $(elem).css({ "padding": percent + "% 0" });
                    $(elem).attr('data-padding', percent + "% 0");
                    if (percent > 16) {
                        $(elem).parent().addClass('card two-five cursor column');
                        $(elem).parent().attr('data-class', 'card two-five cursor column');
                    } else if (percent > 33) {
                        $(elem).parent().addClass('card three-five column');
                        $(elem).parent().attr('data-class', 'card three-five cursor column');
                    } else {
                        $(elem).parent().addClass('card one-five column');
                        $(elem).parent().attr('data-class', 'card one-five cursor column');
                    }
                }
            } else if (card.kind == 'text') {
                $(elem).parent().addClass('card one-five column text');
                $(elem).parent().attr('data-class', 'card one-five column text');
                $(elem).remove();
            } else if (card.kind == 'featured') {
                $(elem).parent().addClass('card ' + card.size + '-five cursor column featured');
                $(elem).parent().attr('data-class', 'card ' + card.size + '-five cursor column featured');
            } else if (card.kind == 'initial') {
                $(elem).parent().addClass('card one-five column initial');
                $(elem).parent().attr('data-class', 'card one-five column initial');
            } else if (card.kind == 'video') {
                $(elem).parent().addClass('card two-five cursor column video');
                $(elem).parent().attr('data-class', 'card two-five cursor column video');
                $(elem).css({ "padding": 35 + "% 0" });
                $(elem).attr('data-padding', 35 + "% 0");
            }
        }
    }
});
