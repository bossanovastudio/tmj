var API_URL = 'http://' + window.location.hostname + ':3000';

$('.remix-container').each(function() {
  var $container = $(this);

  $container.on({
    'reset': function() {
      $(this).removeClass('can-compose can-publish can-share');
    },
    'lock': function() {
      $(this).trigger('reset').addClass('composing');
    },
    'unlock': function() {
      $(this).trigger('reset').removeClass('composing');
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
    }
  });

  // new
  $(this).find('.remix-landing .new').click(function() {
    $container.trigger('lock');
  });

  // cancel
  $(this).find('.remix-composing .cancel').click(function() {
    $container.trigger('unlock');
  });

  // top actions
  $(this).find('.remix-composing .top-actions .next').click(function() {
    $container.trigger('next');
  });

  $(this).find('.remix-composing .top-actions .publish').click(function() {
    $container.trigger('publish');
  });

  $(this).find('.remix-composing .top-actions .skip-share').click(function() {
    $container.trigger('unlock');
  });

  // toolbox
  $(this).find('.remix-composing .toolbox .categories > div').click(function() {
    // todo: check take-photo class

    $container.trigger('compose');
  });

  $(this).find('.remix-composing .toolbox .pictures .go-back').click(function() {
    $container.trigger('lock');
  });
});
