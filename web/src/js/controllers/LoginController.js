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
            
        } else {

        }
    };

    $scope.passwords = [{
		id: 1,
		value: 'mon',
		name: 'monica',
		img: '/img/monica.png'
	},
	{
		id: 2,
		value: 'ceb',
		name: 'cebola',
		img: '/img/cebola.png'
	},
	{
		id: 3,
		value: 'cas',
		name: 'cascao',
		img: '/img/cascao.png'
	},
	{
		id: 4,
		value: 'mag',
		name: 'magali',
		img: '/img/magali.png'
	},
	{
		id: 5,
		value: 'mar',
		name: 'marina',
		img: '/img/marina.png'
	},
	{
		id: 6,
		value: 'den',
		name: 'denise',
		img: '/img/denisejovem.png'
	},
	{
		id: 7,
		value: 'xav',
		name: 'xaveco',
		img: '/img/xaveco.png'
	},
	{
		id: 8,
		value: 'car',
		name: 'carmen',
		img: '/img/carmen.png'
	},
	{
		id: 9,
		value: 'doc',
		name: 'docontra',
		img: '/img/docontra.png'
	},
	{
		id: 10,
		value: 'nim',
		name: 'nimbus',
		img: '/img/nimbus.png'
	}];

	$scope.setMaster = function(pass) {
        $scope.selected1 = pass;
    }

    $scope.isSelected = function(pass) {
        return $scope.selected1 === pass;
    }

});
