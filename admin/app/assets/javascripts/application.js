// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ujs
//= require masonry.pkgd
//= require turbolinks
//= require bootstrap
//= require_tree .

$(document).on('turbolinks:load', function() {
  resizeAdminBottomContent();

  var overlay = $('#overlay'),
  filterList = $('.btn-filter .item ul'),
  filterItem = $('.btn-filter .item');

  filterItem.click(function(e){
    if ($(e.target).is('li')) {
      overlay.hide();
      $(this).find('ul').hide();
    } else {
      $(this).find('ul').show();
      overlay.show();
    }
  })

  overlay.click(function(){
    $(this).hide();
    filterList.hide();
  })



  // $('.cards').find('.card').each(function() {
  //   $(this).attr('style', '');
  //   $(this).attr('class', $(this).attr('data-class'));
  //   $(this).find('.img').css('height', 'auto');
  //   $(this).find('.img').removeClass('no-padding');
  //   $(this).find('.img').css('padding', $(this).attr('data-padding'));
  // });
  // if (!$('.cards').data('masonry')) {
  //   $('.cards').masonry({
  //     itemSelector: '.card',
  //     columnWidth: '.one-five',
  //     percentPosition: false,
  //     gutter: 20,
  //     transitionDuration: 0
  //   });
  // } else {
  //   $('.cards').masonry('reloadItems');
  //   $('.cards').masonry();
  // }
});

function resizeAdminBottomContent() {
  $('.admin-content .bottom-content').css('height', $('.admin-content').height() - 200);
};

$(window).resize(function() {
    resizeAdminBottomContent();
});
