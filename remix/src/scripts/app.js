var API_URL = 'http://' + window.location.hostname + ':3000';

$('.remix-container').each(function() {
  var $remix = $(this);
  var $composer = $remix.find('.remix-composing');

  $remix.on({
    'reset': function() {
      $remix.removeClass('can-choose can-compose can-publish can-share');
      $composer
        .find('.toolbox .toolbox-item').removeClass('on')
        .filter('.category').addClass('on');

      // removes all elements from artboard and display empty message
      $composer.find('.artboard .canvas *').remove();
      $composer.find('.artboard .empty').show();
    },
    'init': function() {
      $(this).trigger('reset').addClass('initial');
    },
    'choose': function() {
      $(this).trigger('reset').addClass('can-choose');
    },
    'compose': function() {
      $(this).trigger('reset').addClass('can-compose');
    },
    'next': function() {
      $(this).trigger('reset').addClass('can-publish');
    },
    'publish': function() {
      $(this).trigger('reset').addClass('can-share');
      // todo: save image
    },
    'finish': function() {
      $(this).trigger('reset').removeClass('initial');
    }
  });

  // new
  $remix.find('.remix-landing .new').click(function() {
    $remix.trigger('init');
  });

  // cancel
  $composer.find('.cancel').click(function() {
    $remix.trigger('finish');
  });

  // top actions
  $composer.find('.top-actions .next').click(function() {
    $remix.trigger('next');
  });

  $composer.find('.top-actions .publish').click(function() {
    $remix.trigger('publish');
  });

  $composer.find('.top-actions .skip-share').click(function() {
    $remix.trigger('finish');
  });

  // toolbox
  $composer.find('.toolbox .categories > div').click(function() {
    // todo: check take-photo class
    $remix.trigger('choose');
  });

  $composer.find('.toolbox .pictures .go-back').click(function(event) {
    $remix.trigger('init');
  });

  // sets picture element to the artboard and hides empty message
  $composer.find('.toolbox .pictures > div[data-picture-src]').click(function() {
    var $picture = $composer.find('.artboard .canvas .picture');
    console.log($(this).data('picture-src'));

    if (!$picture.length) {
      $picture = $('<img>');
      $composer.find('.artboard .canvas').append($picture);
    }

    $picture.attr({ src: $(this).data('picture-src'), alt: '', class: 'picture' });
    $composer.find('.artboard .empty').hide();
  });

  // toggles between
  $composer.find('.toolbox .toggler').click(function() {
    $(this).closest('.toolbox-item').toggleClass('on').siblings().removeClass('on');
  });
});
