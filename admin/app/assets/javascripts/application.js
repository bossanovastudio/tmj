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
        filterOptions = $('ul.filter-options');

    filterItem.click(function(e) {
        if ($(e.target).is('li')) {
            overlay.hide();
            $(this).find('ul').hide();
        } else {
            $(this).find('ul').show();
            overlay.show();
        }
    });

    overlay.click(function() {
        $(this).hide();
        filterList.hide();
    });

    $('.card').click(function() {
        $(this).toggleClass('selected');
        $(this).find('input').prop("checked", !$(this).find('input').prop("checked"));
        if (filterSelectAllCards.hasClass('active')) {
            filterSelectAllCards.removeClass('active');
        } else if ($("#cards-container .card.selected").length == $("#cards-container .card").length) {
            filterSelectAllCards.addClass('active');
        }
    });

    var selected = false;
    $('.btn-status a').click(function() {
        if ($(this).hasClass('select-all')) {
            if (selected) {
                $('.card').removeClass('selected').find('input').prop('checked', false);
                filterSelectAllCards.removeClass('active');
                selected = false;
            } else {
                $('.card').addClass('selected').find('input').prop('checked', true);
                filterSelectAllCards.addClass('active');
                selected = true;
            }
        } else {
            var valid = false;
            $('.card').each(function(i, c) {
                if ($(this).find('input').prop('checked')) {
                    valid = true;
                }
            });
            if (valid) {
                $('.card').css({ opacity: 0.3 });
                var action = $(this).attr('data-action');
                $('#new_card').attr('action', '/cards/' + action);
                $('#new_card')[0].submit();
            }
        }
    });

    $('input.search').on('keyup', function() {
        var context = $(this).val().toLowerCase();
        cardsContainer.find('.card').each(function() {
            var contentText = $(this).find('.content p.text').text().toLowerCase();
            if (contentText.indexOf(context) != -1)
                $(this).show();
            else
                $(this).hide();
        })
        $('.cards').masonry('reloadItems');
        $('.cards').masonry();
    });

    $('.cards').find('.card').each(function() {
        $(this).attr('style', '');
        $(this).css('opacity', 1);
        $(this).attr('class', $(this).attr('data-class'));
        $(this).find('.img').css('height', 'auto');
    });

    setTimeout(function() { initMasonry(); }, 1000);
});

function initMasonry() {
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
}

function resizeAdminBottomContent() {
    $('.admin-content .bottom-content').css('height', $('.admin-content').height() - 200);
};

// On window resize
$(window).resize(function() {
    resizeAdminBottomContent();
});
