tmj.controller('EditUserController', function($rootScope, $location, $scope, $http, $sce, $compile, $routeParams) {
    $rootScope.pageName = 'edit-user';

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

    $scope.passwords = [{
        id: 0,
        value: 'mon',
        name: 'monica',
        img: '/img/monica.png'
    },
    {
        id: 1,
        value: 'ceb',
        name: 'cebola',
        img: '/img/cebola.png'
    },
    {
        id: 2,
        value: 'cas',
        name: 'cascao',
        img: '/img/cascao.png'
    },
    {
        id: 3,
        value: 'mag',
        name: 'magali',
        img: '/img/magali.png'
    },
    {
        id: 4,
        value: 'mar',
        name: 'marina',
        img: '/img/marina.png'
    },
    {
        id: 5,
        value: 'den',
        name: 'denise',
        img: '/img/denisejovem.png'
    },
    {
        id: 6,
        value: 'xav',
        name: 'xaveco',
        img: '/img/xaveco.png'
    },
    {
        id: 7,
        value: 'car',
        name: 'carmen',
        img: '/img/carmen.png'
    },
    {
        id: 8,
        value: 'doc',
        name: 'docontra',
        img: '/img/docontra.png'
    },
    {
        id: 9,
        value: 'nim',
        name: 'nimbus',
        img: '/img/nimbus.png'
    }];

    $scope.passwordChoice = [{
        img: 'img/pass-silhuete.svg' 
    },
    {
        img: 'img/pass-silhuete.svg' 
    },
    {
        img: 'img/pass-silhuete.svg' 
    },
    {
        img: 'img/pass-silhuete.svg'    
    }];
    $scope.numClick = 0;

    $scope.open = false;
    $scope.togglePassword = function () {
        $scope.open = !$scope.open;
        if ($scope.open) {
            $('.overlay-pass').css({"display": "block"});
            $scope.passwordChoice.length = 0;
            $('.after').css({ "left": 10 });
            $scope.numClick = 0;
        } else {
            $('.overlay-pass').css({"display": "none"});
        }
    };
    
    $scope.addToPasswordChoice = function(pass) {
        $scope.numClick = $scope.numClick + 1;
        $scope.passwordChoice.push($scope.passwords[pass.id]);
        if ($scope.numClick == 1){
            $('.after').css({ "left": 55 });
        } else if ($scope.numClick == 2){
            $('.after').css({ "left": 105 });
        } else if ($scope.numClick == 3){
            $('.after').css({ "left": 150 });
        }else{
            $scope.numClick = 0;
            $scope.open = !$scope.open;
            $('.overlay-pass').css({"display": "none"});
        }
    }
    
    $('.cmn-toggle').change(function() {
        if (this.checked) {
            $(this).parent('.switch').find('.img-social').css('opacity', '1');
        } else {
            $(this).parent('.switch').find('.img-social').css('opacity', '0.5');
        }
    });
    

});

