tmj.controller('LoginController', function($rootScope, $scope, $http, $sce, $compile, $routeParams) {

    $rootScope.pageName = 'login';
    $('.initial-loading').hide(0);

    $scope.form = {};

    $scope.passwords = [{
        id: 0,
        value: 'mon',
        name: 'monica',
        img: '/img/monica.png'
    }, {
        id: 1,
        value: 'ceb',
        name: 'cebola',
        img: '/img/cebola.png'
    }, {
        id: 2,
        value: 'cas',
        name: 'cascao',
        img: '/img/cascao.png'
    }, {
        id: 3,
        value: 'mag',
        name: 'magali',
        img: '/img/magali.png'
    }, {
        id: 4,
        value: 'mar',
        name: 'marina',
        img: '/img/marina.png'
    }, {
        id: 5,
        value: 'den',
        name: 'denise',
        img: '/img/denisejovem.png'
    }, {
        id: 6,
        value: 'xav',
        name: 'xaveco',
        img: '/img/xaveco.png'
    }, {
        id: 7,
        value: 'car',
        name: 'carmen',
        img: '/img/carmen.png'
    }, {
        id: 8,
        value: 'doc',
        name: 'docontra',
        img: '/img/docontra.png'
    }, {
        id: 9,
        value: 'nim',
        name: 'nimbus',
        img: '/img/nimbus.png'
    }];

    $scope.passwordChoice = [{
        img: 'img/pass-silhuete.svg',
        value: 0
    }, {
        img: 'img/pass-silhuete.svg',
        value: 0
    }, {
        img: 'img/pass-silhuete.svg',
        value: 0
    }, {
        img: 'img/pass-silhuete.svg',
        value: 0
    }];
    $scope.numClick = 0;

    $scope.open = false;
    $scope.togglePassword = function() {
        $scope.open = !$scope.open;
        if ($scope.open) {
            $('.overlay-pass').css({ "display": "block" });
            $scope.passwordChoice.length = 0;
            $('.after').css({ "left": 10 });
            $scope.numClick = 0;
        } else {
            $('.overlay-pass').css({ "display": "none" });
        }
    };

    $scope.addToPasswordChoice = function(pass) {
        $scope.numClick = $scope.numClick + 1;
        $scope.passwordChoice.push($scope.passwords[pass.id]);
        if ($scope.numClick == 1) {
            $('.after').css({ "left": 55 });
        } else if ($scope.numClick == 2) {
            $('.after').css({ "left": 105 });
        } else if ($scope.numClick == 3) {
            $('.after').css({ "left": 150 });
        } else {
            $scope.numClick = 0;
            $scope.open = !$scope.open;
            $('.overlay-pass').css({ "display": "none" });
        }
    }

    $scope.msg = 'Minha Área';
    $scope.msg_register = 'Cadastrar';

    $scope.login = function() {
        $scope.form.password = $scope.passwordChoice.map(function(p) {
            return p.value;
        }).join('');

        console.log($scope.form);

        if (!$scope.form.username || $scope.form.username.length < 1) {
            $scope.msg = 'Preencha seu apelido';
            return false;
        } else if ($scope.form.password.length != 12) {
            $scope.msg = 'Senha inválida';
            return false;
        }
        $scope.msg = 'Minha Área';
        $http.post("/user/sign_in.json", {
                user: $scope.form
            }, {
                headers: { 'Content-Type': 'application/json' }
            })
            .then(function(response) {
                $scope.msg = 'Obrigado.';
                $location.path('/');
            }, function(response) {
                $scope.msg = 'Ocorreu um erro, tente novamente.';
            });
    }

    $scope.register = function() {
        $scope.form.password = $scope.passwordChoice.map(function(p) {
            return p.value;
        }).join('');

        console.log($scope.form);

        if (!$scope.form.username || $scope.form.username.length < 1) {
            $scope.msg_register = 'Preencha seu apelido';
            return false;
        } else if (!$scope.form.email || $scope.form.email.length < 1) {
            $scope.msg_register = 'Email inválido';
            return false;
        } else if ($scope.form.password.length != 12) {
            console.log('password');
            $scope.msg_register = 'Senha inválida';
            return false;
        }
        $scope.msg_register = 'Cadastrar';
        $http.post("/user.json", {
                user: $scope.form
            }, {
                headers: { 'Content-Type': 'application/json' }
            })
            .then(function(response) {
                $scope.msg_register = 'Obrigado.';
                $location.path('/');
            }, function(response) {
                $scope.msg_register = 'Ocorreu um erro, tente novamente.';
            });
    }

});
