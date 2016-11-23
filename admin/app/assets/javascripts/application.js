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
      filterItem = $('.btn-filter .item'),
      filterSelectAllCards = $('.filter-bar a.select-all'),
      cardsContainer = $('#cards-container'),
      socialOptions = $('ul.social-options'),
      statusOptions = $('ul.status-options');

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

  socialOptions.click(function(e) {
    $(this).children('li').removeClass('active');
    $(e.target).addClass('active');
    $('.social .main-select').text($(e.target).text());
  });

  statusOptions.click(function(e) {
    $(this).children('li').removeClass('active');
    $(e.target).addClass('active');
    $('.status .main-select').text($(e.target).text());
  });

  filterSelectAllCards.click(function() {
    $(this).toggleClass('active');
    if ($(this).hasClass('active'))
      cardsContainer.children('.card').addClass('selected');
    else
      cardsContainer.children('.card').removeClass('selected');
  });

  $('.card').click(function() {
    $(this).toggleClass('selected');
    if (filterSelectAllCards.hasClass('active')){
      filterSelectAllCards.removeClass('active');
    } else if ($("#cards-container .card.selected").length == $("#cards-container .card").length) {
      filterSelectAllCards.addClass('active');
    }
    console.log("cards selecionados: " + $("#cards-container .card.selected").length);
    console.log("cards totais: " + $("#cards-container .card").length);
  });

  $('.btn-status a.accept').click(function() {
    var cardIds = [];
    cardsContainer.children('.card.selected').each(function () {
      cardIds.push($(this).attr('data-id'));
    });

    $.ajax({
          url: '/cards/accept',
          method: 'POST',
          data: {
            card: {id: cardIds}
          },
          success: function(data) {
            console.log(data);
          },
          error: function(data) {
            console.log(data);
          }
        })
  });



  $('.cards').find('.card').each(function() {
    $(this).attr('style', '');
    $(this).css('opacity', 1);
    $(this).attr('class', $(this).attr('data-class'));
    $(this).find('.img').css('height', 'auto');
    $(this).find('.img').removeClass('no-padding');
    $(this).find('.img').css('padding', $(this).attr('data-padding'));
    $(this).addClass('card one-five column');
    $(this).attr('data-class', 'card one-five column');
  });
  if (!$('.cards').data('masonry')) {
    $('.cards').masonry({
      itemSelector: '.card',
      columnWidth: '.one-five',
      percentPosition: false,
      gutter: 20,
      transitionDuration: 0
    });
  } else {
    $('.cards').masonry('reloadItems');
    $('.cards').masonry();
  }
});

function resizeAdminBottomContent() {
  $('.admin-content .bottom-content').css('height', $('.admin-content').height() - 200);
};

// On window resize
$(window).resize(function() {
    resizeAdminBottomContent();
});
