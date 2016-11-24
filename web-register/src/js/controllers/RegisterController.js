tmj.controller('RegisterController', function($rootScope, $location, $scope, $http, $sce, $compile, $routeParams) {
    $scope.form = {};


    //temporary
    // $('.form.active').removeClass('active');
    // $('.form').eq(3).addClass('active');
    //temporary

    $('.form.active').css({ left: 0 });

    $scope.validForm = function() {
        var valid = true;
        $('.form.active').find('.field').each(function(i, f) {
            if ($(f).hasClass('simple')) {
                if ($(f).find('input, textarea, select').val().length < 1) {
                    $(f).find('input, textarea, select').addClass('error');
                    valid = false;
                } else {
                    $(f).find('input, textarea, select').removeClass('error');
                }
            } else if ($(f).hasClass('files')) {
                $(f).find('input').each(function(i, f) {
                    if ($(f).val().length < 1) {
                        $(f).parent().find('label').addClass('error');
                        valid = false;
                    } else {
                        $(f).parent().find('label').removeClass('error');
                    }
                });
            } else if ($(f).hasClass('boolean')) {
                var checked = $(f).find('.option').find('input:checked').length;
                if (checked == 0) {
                    $(f).find('.option').addClass('error');
                    valid = false;
                } else {
                    $(f).find('.option').removeClass('error');
                }
                var value = $(f).find('.option').find('input:checked').val();
                if (value == 1) {
                    if ($(f).find('.contentField').val().length < 1) {
                        $(f).find('.contentField').addClass('error');
                        valid = false;
                    } else {
                        $(f).find('.contentField').removeClass('error');
                    }
                }
            } else if ($(f).hasClass('terms')) {
                var value = $(f).find('input:checked').val();
                if (!value) {
                    $(f).find('.placeholder').addClass('error');
                    valid = false;
                } else {
                    $(f).find('.placeholder').removeClass('error');
                }
            }
        });
        return valid;
    }

    $scope.advanceForm = function() {
        if ($scope.validForm()) {
            var currentForm = $('.form.active');
            currentForm.animate({
                left: "-150%"
            }, 1000, function() {
                var index = $('.form.active').index();
                if (index < 3) {
                    var newForm = $('.form').eq(index + 1);
                    $('.form').removeClass('active');
                    newForm.addClass('active');
                    newForm.animate({
                        left: 0
                    });
                    $('.step').removeClass('active');
                    $('.step').eq(newForm.index()).addClass('active');
                }
            });
        }
    }

    $scope.sendForm = function() {
        // (send this to the moon).then => {
        $scope.advanceForm();
        //}
    }

    $scope.returnForm = function() {
        var currentForm = $('.form.active');
        currentForm.animate({
            left: "150%"
        }, 1000, function() {
            var index = $('.form.active').index();
            if (index > 0) {
                var newForm = $('.form').eq(index - 1);
                $('.form').removeClass('active');
                newForm.addClass('active');
                newForm.animate({
                    left: 0
                });
                $('.step').removeClass('active');
                $('.step').eq(newForm.index()).addClass('active');
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
