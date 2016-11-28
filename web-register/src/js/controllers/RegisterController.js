tmj.controller('RegisterController', function($rootScope, $location, $scope, $http, $sce, $compile, $routeParams) {
    $scope.form = {};
    $scope.form.newsletter = '1';


    //temporary
    $('.form.active').removeClass('active');
    $('.form').eq(2).addClass('active');
    //temporary

    $http.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded";
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
            } else if ($(f).hasClass('termsValidate')) {
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
            $('.overlay').fadeOut();
            var currentForm = $('.form.active');
            currentForm.animate({
                left: "-150%"
            }, 500, function() {
                var index = $('.form.active').index();
                if (index < 3) {
                    var newForm = $('.form').eq(index + 1);
                    $('.form').removeClass('active');
                    newForm.addClass('active');
                    newForm.animate({
                        left: 0
                    }, 500);
                    $('.step').removeClass('active');
                    $('.step').eq(newForm.index()).addClass('active');
                    $('.forms').animate({ scrollTop: 0 });
                }
            });
        }
    }

    $scope.sendForm = function() {
        if ($scope.validForm()) {
            $http({
                    method: 'POST',
                    data: $.param($scope.form),
                    url: API_URL + '/api/register.json',
                })
                .then(function(data) {
                    $scope.advanceForm();
                }, function(data) {
                    console.log(data);
                });
        }
    }

    $scope.returnForm = function() {
        var currentForm = $('.form.active');
        currentForm.animate({
            left: "150%"
        }, 500, function() {
            var index = $('.form.active').index();
            if (index > 0) {
                var newForm = $('.form').eq(index - 1);
                $('.form').removeClass('active');
                newForm.addClass('active');
                newForm.animate({
                    left: 0
                }, 500);
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
        var field = event.target;
        var file = field.files[0];
        var reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function() {
            var base64 = reader.result;
            if ($(field).attr('id') == 'photo_face') {
                $scope.form.photo_face = base64;
            } else if ($(field).attr('id') == 'photo_body') {
                $scope.form.photo_body = base64;
            } else if ($(field).attr('id') == 'photo_upperbody') {
                $scope.form.photo_upperbody = base64;
            }
        };
        var h = $(field).closest('.file');
        h.find('label').text(file.name).css({ color: "#ffffff" });
    };

    $scope.checkField = function(event) {
        var e = angular.element(event.target);
        var choice = $(e).closest('.boolean');
        var input = $(e).find('input');
        $(input).prop('checked', true);
        if ($(input).attr('value') == "1") {
            $(choice).addClass('active');
            $scope.form[$(input).attr('name')] = true;
        } else {
            $(choice).removeClass('active');
            $scope.form[$(input).attr('name')] = false;
        }
        $(choice).find('.option').removeClass('active');
        $(e).addClass('active');
    }

});
