tmj.controller('LoginController', function($rootScope, $scope, $http, $sce, $compile, $routeParams) {
        
    $('.initial-loading').hide(0);
    $('.purple-overlay').show();

    // $scope.openPassword = function($event) {
    //     if ($('.pass-box').hasClass('show')){
    //         $('.pass-box').removeClass('show');
    //     } else{
    //         $('.pass-box').addClass('show');
    //     }
    // }

    $scope.open = false;
    $scope.togglePassword = function () {
        $scope.open = !$scope.open;

        if ($scope.open) {
        	$scope.passwordChoise.length = 0;
            
        } else {

        }
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

	$scope.passwordChoise = [];
	$scope.numClick = 0;
	$scope.addToPasswordChoise = function(pass) {
		$scope.numClick = $scope.numClick + 1;
		$scope.passwordChoise.push($scope.passwords[pass.id]);
		if ($scope.numClick == 1){
			$('.after').css({ "left": 55 });
		} else if ($scope.numClick == 2){
			$('.after').css({ "left": 95 });
		} else{
			$('.after').css({ "left": 10 });
			$scope.numClick = 0;
	        $scope.open = !$scope.open;
		}
	}

});
