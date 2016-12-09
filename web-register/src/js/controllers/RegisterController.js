tmj.controller('RegisterController', function($rootScope, $location, $scope, $http, $sce, $compile, $routeParams) {
    $scope.form = {};
    $scope.form.newsletter = '1';


    //temporary
    // $('.form.active').removeClass('active');
    // $('.form').eq(2).addClass('active');
    //temporary

    $http.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded";
    $('.form.active').css({ left: 0 });

    $scope.validateCPF = function(strCPF) {
        strCPF = strCPF.replace('.', '');
        strCPF = strCPF.replace('.', '');
        strCPF = strCPF.replace('-', '');
        var sum;
        var rest;
        sum = 0;
        if (strCPF == "00000000000") return false;
        for (i = 1; i <= 9; i++) sum = sum + parseInt(strCPF.substring(i - 1, i)) * (11 - i);
        rest = (sum * 10) % 11;
        if ((rest == 10) || (rest == 11)) rest = 0;
        if (rest != parseInt(strCPF.substring(9, 10))) return false;
        sum = 0;
        for (i = 1; i <= 10; i++) sum = sum + parseInt(strCPF.substring(i - 1, i)) * (12 - i);
        rest = (sum * 10) % 11;
        if ((rest == 10) || (rest == 11)) rest = 0;
        if (rest != parseInt(strCPF.substring(10, 11))) return false;
        return true;
    }

    $scope.validForm = function() {
        var valid = true;
        $('.form.active').find('.field').each(function(i, f) {
            if ($(f).hasClass('simple')) {
                if ($(f).find('input, textarea, select').val().length < 1 && !$(f).find('input, textarea, select').hasClass('except')) {
                    $(f).find('input, textarea, select').addClass('error');
                    valid = false;
                } else {
                    $(f).find('input, textarea, select').removeClass('error');
                }

                // CPF
                if ($(f).find('#document_cpf, #adult_document_cpf').length > 0) {
                    var field = $(f).find('#document_cpf, #adult_document_cpf');
                    var cpf = field.val();
                    if (cpf.length > 0 && !$scope.validateCPF(field.val())) {
                        field.addClass('error');
                        valid = false;
                    } else {
                        field.removeClass('error');
                    }
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
        console.log(valid);
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
            var btn = $("#btn-send");
            btn.attr('disabled', 'disabled');
            $('.dark-overlay').fadeIn();
            $http({
                    method: 'POST',
                    data: $.param($scope.form),
                    url: API_URL + 'register.json',
                })
                .then(function(data) {
                    $scope.advanceForm();
                    $('.dark-overlay').fadeOut();
                    btn.removeAttr('disabled');
                }, function(data) {
                    console.log(data);
                    $('.dark-overlay').fadeOut();
                    btn.removeAttr('disabled');
                });
        }
    }

    setTimeout(function() {
        $('#newsletter').prop('checked', true);
    }, 1000);

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
