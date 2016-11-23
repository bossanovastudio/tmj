tmj.controller('RegisterController', function($rootScope, $location, $scope, $http, $sce, $compile, $routeParams) {
    $scope.form = {};

    $('.form.active').css({left: 0});

    $scope.advanceForm = function() {
        var currentForm = $('.form.active');
        currentForm.animate({
            left: "-150%"
        }, 1000, function() {
            var index = $('.form.active').index();
            if (index < 2) {
                var newForm = $('.form').eq(index+1);
                $('.form').removeClass('active');
                newForm.addClass('active');
                newForm.animate({
                    left: 0
                });
            }
        });
    }

    $scope.returnForm = function() {
        var currentForm = $('.form.active');
        currentForm.animate({
            left: "150%"
        }, 1000, function() {
            var index = $('.form.active').index();
            if (index > 0) {
                var newForm = $('.form').eq(index-1);
                $('.form').removeClass('active');
                newForm.addClass('active');
                newForm.animate({
                    left: 0
                });
            }
        });
    }

    $scope.selectFile = function(event) {
        var e = angular.element(event.target);
        var h = $(e).closest('.file');
        h.find('input').trigger('click');
    }

    $scope.changedFile = function(event) {
        var files = event.target.files;
        var e = angular.element(event.target);
        var h = $(e).closest('.file');
        h.find('label').text(files[0].name).css({ color: "#ffffff" });
        console.log(files);
    };

    $scope.checkField = function(event) {
        var e = angular.element(event.target);
        var choice = $(e).closest('.boolean');
        var input = $(e).find('input');
        $(input).prop('checked', true);
        if (input.attr('value') == "1") {
            $(choice).addClass('active');
        } else {
            $(choice).removeClass('active');
        }
        $(choice).find('.option').removeClass('active');
        $(e).addClass('active');
    }

});
