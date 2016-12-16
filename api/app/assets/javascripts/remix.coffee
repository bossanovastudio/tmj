#= require 'jquery'
#= require 'jquery-ujs'
#= require 'jquery-touchswipe'
#= require 'jquery-ui/ui/version'
#= require 'jquery-ui/ui/plugin'
#= require 'jquery-ui/ui/data'
#= require 'jquery-ui/ui/disable-selection'
#= require 'jquery-ui/ui/scroll-parent'
#= require 'jquery-ui/ui/safe-active-element'
#= require 'jquery-ui/ui/safe-blur'
#= require 'jquery-ui/ui/widget'
#= require 'jquery-ui/ui/widgets/mouse'
#= require 'jquery-ui/ui/widgets/resizable'
#= require 'jquery-ui/ui/widgets/draggable'
#= require 'jqueryui-touch-punch'
#= require 'jquery-ui-rotatable/jquery.ui.rotatable'
#= require 'html2canvas'
#= require 'mustache.js/mustache'
#= require 'bluebird'
#= require 'exif-js/exif'

API_URL = '/api/remix'
DATA_BGS = []
DATA_TXT_COLORS = []
DATA_CSS_EFFECT_NAME = ['grayscale', 'sepia', 'filter_2', 'filter_3', 'none']
DATA_CSS_EFFECTS = [
  {
    '-webkit-filter': 'grayscale(1)',
    '-moz-filter': 'grayscale(1)',
    'filter': 'grayscale(1)'
  }
  {
    '-webkit-filter': 'sepia(1)',
    '-moz-filter': 'sepia(1)',
    'filter': 'sepia(1)'
  }
  {
    '-webkit-filter': 'sepia(1) hue-rotate(200deg)',
    '-moz-filter': 'sepia(1) hue-rotate(200deg)',
    'filter': 'sepia(1) hue-rotate(200deg)'
  }
  {
    '-webkit-filter': 'contrast(1.4) saturate(1.8) sepia(.6)',
    '-moz-filter': 'contrast(1.4) saturate(1.8) sepia(.6)',
    'filter': 'contrast(1.4) saturate(1.8) sepia(.6)'
  }
  {
    '-webkit-filter': 'none',
    '-moz-filter': 'none',
    'filter': 'none'
  }
]



window.isMobile = ->
  return $(window).width() < 768

window.isDesktop = ->
  return $(window).width() >= 768

parseColor = (x) ->
  x = parseInt(x).toString(16);
  if x.length==1
    x = "0" + x
  else
    x = x

getRotationDegrees = (x) ->
  matrix = x.css("-webkit-transform") || x.css("-moz-transform") || x.css("-ms-transform") || x.css("-o-transform") || x.css("transform");
  if matrix != 'none'
    values = matrix.split('(')[1].split(')')[0].split(',');
    a = values[0];
    b = values[1];
    angle = Math.atan2(b, a) * (180.0 / Math.PI);
  else
    angle = 0
  if angle < 0
    angle + 360
  else
    angle

parseColorTransparent = (x) ->
  if x.css('background-color') == "transparent"
    x = "transparent"
  else
    x = (x.css('background-color').split("(")[1].split(")")[0].split(",").map parseColor).join("")

window.getCanvasSize = () ->
  if !isMobile()
    size = 502
  else
    size = 320

window.getElements = ->
  elements = [];
  background_effect = 'none'
  if $('.remix-container').data('effects-index') != undefined
    background_effect = DATA_CSS_EFFECT_NAME[$('.remix-container').data('effects-index') - 1]
  background = {
    type: 'background',
    src: $('.picture.canvas-background').attr('src'),
    color: ($('.remix-canvas').css('background-color').split("(")[1].split(")")[0].split(",").map parseColor).join(""),
    custom: $('.picture.canvas-background').data('custom'),
    effect: background_effect
  }
  if $('.remix-canvas').find('.pattern').attr('src') && $('.remix-canvas').find('.pattern').attr('src').length > 1
    background.pattern = $('.remix-canvas').find('.pattern').attr('src')
  elements.push(background);

  $('.element').each ->
    $el = $(this);
    if $el.hasClass('image')
      elements.push({
        src: $el.find('img').attr('src'),
        width: $el.find('img').width(),
        height: $el.find('img').height(),
        position: [$el.offset().left - $el.parent().offset().left, $el.offset().top - $el.parent().offset().top]
        type: 'image',
        rotation: getRotationDegrees $el
      })
    else
      elements.push({
        type: 'text',
        position: [$el.offset().left - $el.parent().offset().left, $el.offset().top - $el.parent().offset().top]
        size: $el.css('font-size').replace('px',''),
        content: $el.find('textarea').val(),
        width: $el.width(),
        height: $el.height(),
        fg: ($el.css('color').split("(")[1].split(")")[0].split(",").map parseColor).join(""),
        bg: parseColorTransparent $el,
      })

  return {
    elements: elements,
    mobile: isMobile(),
    canvas_side: getCanvasSize()
  }

getApiData = (options) ->
  if !options || !options.entity
    return []

  url = API_URL + '/' + options.entity

  if options.id
    url += '/' + options.id

  url += '.json'

  if options.qs
    url += '?' + options.qs

  $.ajax {
    url: url
    type: 'get'
    dataType: 'json',
  }
  .fail ->
    alert 'Não foi possível carregar os dados da API. URL:' + url

getCategories = ->
  getApiData { entity: 'categories' }

getCategory = (id) ->
  getApiData { entity: 'categories', id: id }
  .done (data) ->
    return data.map (item) ->
      return $.extend item, { category_id: id }

getBackgrounds = (id) ->
  getApiData { entity: 'backgrounds' }

getBalloons = (id) ->
  getApiData { entity: 'stickers', qs: 'kind=speech_balloon' }

getStickers = (id) ->
  getApiData { entity: 'stickers', qs: 'kind=common_sticker' }

getTextColors = (id) ->
  getApiData { entity: 'text_colors' }

getPatterns = (id) ->
  getApiData { entity: 'patterns' }

$('.remix-container').each ->
  $remix = $(this)
  $gallery = $remix.find('.remix-gallery')
  $composer = $remix.find('.remix-composer')
  $canvas = $composer.find('.remix-canvas')
  $loader = $remix.find('.remix-loader')

  # ajax categories
  Promise.props {
    categories: getCategories()
    backgrounds: getBackgrounds()
    balloons: getBalloons()
    stickers: getStickers()
    text_colors: getTextColors()
    patterns: getPatterns()
  }
  .then (result) ->
    result.pictures = []
    result.categories.forEach (category) ->
      result.pictures.push getCategory(category.id)

    return Promise.all result.pictures
    .then (pictures) ->
      result.pictures = pictures

      return result
  .then (result) ->
    # categories
    html = ''
    template = '<div class="item" data-id="{{ id }}"><div><img crossorigin="anonymous" src="{{ &url }}" alt="{{ name }}"></div></div>'
    Mustache.parse template

    result.categories.forEach (category) ->
      html += Mustache.render template, category

    $composer.find('.toolbox-item.category .categories').append(html)

    # pictures
    html = ''
    template = '<div class="item" data-category-id="{{ category_id }}" data-picture-src="{{ &url }}"><div><img crossorigin="anonymous" src="{{ &url }}" alt=""></div></div>'
    Mustache.parse template

    result.pictures.forEach (category) ->
      category.forEach (picture) ->
        html += Mustache.render template, picture

    $composer.find('.toolbox-item.category .pictures').append(html)

    # backgrounds
    if result.backgrounds?
      DATA_BGS = result.backgrounds.filter (bg) ->
        return (bg.color != '#FFFFFF' && bg.color != '#FFF')

    DATA_BGS.push { color: '#FFFFFF' }

    # balloons
    html = ''
    template = '<div class="elements-item" data-src="{{ &url }}"><img src="{{ &url }}" alt="" crossorigin="anonymous"></div>'
    Mustache.parse template

    result.balloons.forEach (balloon) ->
      html += Mustache.render template, balloon

    $composer.find('.toolbox-item.balloons .elements').append(html)

    # stickers
    html = ''
    template = '<div class="elements-item" data-src="{{ &url }}"><img src="{{ &url }}" alt="" crossorigin="anonymous"></div>'
    Mustache.parse template

    result.stickers.forEach (sticker) ->
      html += Mustache.render template, sticker

    $composer.find('.toolbox-item.stickers .elements').append(html)

    # patterns
    html = ''
    template = '<div class="elements-item pattern" data-src="{{ &url }}"><img src="{{ &url }}" alt="" crossorigin="anonymous"></div>'
    Mustache.parse template

    result.patterns.forEach (sticker) ->
      html += Mustache.render template, sticker

    $composer.find('.toolbox-item.patterns .elements').append(html)

    # text colors
    if result.text_colors?
      DATA_TXT_COLORS = result.text_colors.filter (color) ->
        return (color.background != '#000000' && color.background != '#000')

    DATA_TXT_COLORS.push { foreground: '#000000', background: '#000000' }

    # hides loading
    $loader.fadeOut 0, ->
      $(this).remove()


  $remix.on
    'reset': ->
      # removes all states
      $remix.removeClass('can-choose-picture can-compose can-publish can-share')

      # goes back to category tool selection
      $composer
        .find('.toolbox .toolbox-item').removeClass('on')
        .filter('.category').addClass('on')

      # resets scroll for categories and pictures popup (mobile)
      $composer.find('.toolbox .toolbox-item.category .popup .popup-holder').scrollLeft(0)

      # removes all elements from artboard and display empty message
      $canvas.removeAttr('style')
      $canvas.children().remove()
      $composer.find('.artboard .empty').show()

      # resets storages
      $remix.removeData('last-element')
      $remix.removeData('text-color')
      $remix.removeData('colors-index')
      $remix.removeData('effects-index')
      $remix.removeData('text-colors-index')

    # initialize state: can select a category of pictures
    'init': ->
      $(this).trigger('reset').addClass('initial')

    # choose state: can choose a picture to background elements
    'choose-picture': (event, id) ->
      $(this).addClass('can-choose-picture')

      $composer.find('.toolbox .toolbox-item.category .pictures .item')
        .removeClass('on')

      # selects the holder of picture
      $composer.find('.toolbox .toolbox-item.category .pictures .item[data-category-id="' + id + '"]')
        .addClass('on')

      # selects the holder of picture
      $composer.find('.toolbox .toolbox-item.category .categories .item')
        .removeClass('on')

      # resets scroll for categories and pictures popup (mobile)
      $composer.find('.toolbox .toolbox-item.category .popup .popup-holder').scrollLeft(0)

    # compose state: can compose elements above the chosen picture
    'compose': ->
      $composer.find('.toolbox .toolbox-item').removeClass('on')
      $(this).removeClass('can-choose-picture').addClass('can-compose')

    # publish state: can publish the composed image to the site and generate an image
    'publish': ->
      $(this).removeClass('can-compose').addClass('can-publish')

    # share state: can share the generated image to networks
    'share': ->
      $(this).removeClass('can-compose can-publish').addClass('can-share')

      # removes selects of any element in canvas and the click event
      $canvas.find('.element').trigger('remix:deselect-element').off('click')
      $elements = getElements()
      $canvas.html('');
      $.ajax {
        url: API_URL
        method: 'POST'
        data: $elements
        dataType: 'json'
      }
      .done (data) ->
        $canvas.html('<img src="' + data.share_url + '" alt="" style="width: 100%;">')
        $('#facebook_share_btn').attr('href', 'https://www.facebook.com/sharer/sharer.php?u=' + data.share_url)
        $('#twitter_share_btn').attr('href', 'https://twitter.com/intent/tweet?text=Remix ' + data.share_url)
        $('#tumblr_share_btn').attr('href', 'http://www.tumblr.com/share/link?url=' + data.share_url)
        $composer.find('.actions .download').attr({'href': data.share_url, 'target': '_blank'})
        $('.gallery-item-new').after('<div class="gallery-item" data-id="' + data.id + '"><img src="' + data.share_url + '" class="picture" /></div>');
      .fail ->
        alert 'Não foi possível salvar a imagem'

    # finish state
    'finish': ->
      $(this).trigger('reset').removeClass('initial')

    # sets picture element to the artboard and hides empty message
    'set-picture': (event, src) ->
      $picture = $canvas.find('.picture')

      if !$picture.length
        $picture = $('<img>')
        $canvas.append $picture

      $picture
        .attr { class: 'picture canvas-background', src: src, crossorigin: 'anonymous' }
      $picture.css {
        opacity: 0
      }

      if src.indexOf('data') == 0
        setTimeout ( ->
            w = $picture.width()
            h = $picture.height()
            if w == h
              $picture.css {
                width: '100%'
                height: '100%'
              }
            else if w > h
              $picture.css {
                width: '100%'
                height: 'auto'
              }
            else
              $picture.css {
                width: 'auto'
                height: '100%'
              }
          ), 100
        $picture.data({ custom: true })
      setTimeout ( ->
          $picture.css {
            opacity: 1
          }
        ), 100


      $composer.find('.artboard .empty').hide()

    # sets picture element to the artboard and hides empty message
    'add-image': (event, src) ->
      $element = $('<div>').attr { class: 'element image' }

      $('<img>').attr { src: src, alt: '', crossOrigin: 'anonymous' }
        .appendTo $element

      $('<div>').attr { class: 'action remove' }
        .on 'click', ->
          $(this).parent().remove()
        .appendTo $element

      # appends element to last
      $canvas.append $element

      # applies drag and resize abilities. select, deselect and click events too
      $element
        .draggable {
          scroll: false
          disabled: true
          containment: 'parent'
        }
        .resizable {
          disable: true
          aspectRatio: true
          minWidth: 50
          minHeight: 50
          containment: 'parent'
          handles: 'se'
          classes:
            'ui-resizable-se': 'action resize'
            'ui-resizable-sw': ''
        }
        .rotatable {
          handle: $('<div>').addClass('ui-rotatable-handle ui-draggable action rotate')
          rotationCenterX: 50
          rotationCenterY: 50
        }
        .on {
          'remix:select-element': ->
            $(this)
              .addClass('focus')
              .draggable('enable')
              .resizable('enable')
              .rotatable('enable')
              .siblings('.element').trigger('remix:deselect-element')

          'remix:deselect-element': ->
            $(this)
              .removeClass('focus')
              .draggable('disable')
              .resizable('disable')
              .rotatable('disable')

          click: (event) ->
            event.stopPropagation()
            $(this).trigger('remix:select-element')
        }

      # stores last used element
      $remix.data('last-element', $element)

    'add-text': (event, cssClass) ->
      $element = $('<div>').attr { class: 'element text ' + cssClass }

      if $remix.data('text-color')
        $element.css({
          'background-color': $remix.data('text-color')['background-color']
          'color': $remix.data('text-color')['color']
        })

      $('<textarea>')
        .attr {
          autocomplete: 'off'
          autocorrect: 'off'
          autocapitalize: 'off'
          spellcheck: 'false'
        }
        .on 'input', ->
          iOS = /iPhone|iPod|iPad/i.test(navigator.userAgent);
          $hidden = $(this).siblings('.hidden-content')
          $hidden.html(this.value.replace(/\n/g, '<br>'))
          if iOS
            $(this).css {
              minWidth: 150
              maxWidth: 150
              width: 150
              height: $hidden.height()
            }
          else
            $(this).css {
              width: $hidden.width() + 5
              height: $hidden.height()
            }

        .on 'mousedown', ->
          if $(this).closest('.element').hasClass('focus')
            $(this).attr('readonly', false).trigger('focus')
        .appendTo $element

      $('<div>').attr { class: 'hidden-content' }
        .appendTo $element

      $('<div>').attr { type: 'button', class: 'action remove' }
        .on 'click', ->
          $(this).parent().remove()
        .appendTo $element

      $('<div>').attr { class: 'action drag' }
        .appendTo $element

      # appends element to last and trigger textarea focus
      $canvas.append $element

      $element
        .draggable {
          scroll: false
          disabled: true
          containment: 'parent'
          handle: '.drag'
        }
        .on {
          'remix:select-element': ->
            $(this)
              .draggable('enable')
              .addClass('focus')
              .siblings('.element').trigger('remix:deselect-element')

            $(this).find('textarea').trigger('focus')

          'remix:deselect-element': ->
            if $(this).find('textarea').val() == ''
              $(this).remove()
            else
              $(this)
                .draggable('disable')
                .removeClass('focus')

              $(this).find('textarea').attr('readonly', true)

          click: (event) ->
            event.stopPropagation()
            $(this).trigger('remix:select-element')
        }

      # stores last used element
      $remix.data('last-element', $element)

  # gallery swipe
  $gallery.each ->
    $(this).on 'remix:gallery-adapt', ->
      if window.isDesktop()
        $(this).find('.gallery-item').removeAttr('style')
        $(this).find('.gallery-holder').removeAttr('style')
      else
        itemWidth = $(this).width() - (40 * 2)
        totalWidth = (itemWidth * $(this).find('.gallery-item').length) + (40 * 2)
        $(this).find('.gallery-item').outerWidth(itemWidth)
        $(this).find('.gallery-holder').outerWidth(totalWidth)
        $(this).scrollLeft(0)
    .trigger 'remix:gallery-adapt'

    $(this).swipe {
      swipeLeft: (event, direction, duration, fingerCount, fingerData, currentDirection) ->
        width = $(this).find('.gallery-item').first().outerWidth(true)
        $(this).animate({ scrollLeft: ('+=' + width) }, 100)

      swipeRight: (event, direction, duration, fingerCount, fingerData, currentDirection) ->
        width = $(this).find('.gallery-item').first().outerWidth(true)
        $(this).animate({ scrollLeft: ('-=' + width) }, 100)
    }

    $(this).find('.gallery-item').find('.actions .share').click ->
      $('#facebook_share_btn').attr('href', 'https://www.facebook.com/sharer/sharer.php?u=' + $image.attr('src'))
      $('#twitter_share_btn').attr('href', 'https://twitter.com/intent/tweet?text=Remix ' + $image.attr('src') + ' #tmjofilme')
      $('#tumblr_share_btn').attr('href', 'http://www.tumblr.com/share/link?url=' + $image.attr('src') + ' #tmjofilme')

    # $(this).find('.gallery-item').find('.picture').on click ->
    $(this).on click: ->
      $item = $(this).closest('.gallery-item')
      $image = $(this).closest('.gallery-item').find('.picture').clone()
      $image.appendTo($canvas)

      $('#facebook_share_btn').attr('href', 'https://www.facebook.com/sharer/sharer.php?u=' + $image.attr('src'))
      $('#twitter_share_btn').attr('href', 'https://twitter.com/intent/tweet?text=Remix ' + $image.attr('src') + ' #tmjofilme')
      # $('#tumblr_share_btn').attr('href', 'http://www.tumblr.com/share/link?url=' + $image.attr('src'))

      $composer.find('.artboard .empty').hide()
      $composer.find('.actions .download').attr('href', $image.attr('src'))
      $composer.find('.actions .remove').data('id', $item.data('id'))
      $remix.addClass('initial can-share')
    , '.gallery-item .picture'

  $(window).resize ->
    $gallery.trigger 'remix:gallery-adapt'

  $composer.find('.actions .remove').click ->
    b = $(this);
    id = $(this).data('id')
    b.animate({opacity: 0.2});
    $.ajax {
      url: API_URL + '/delete'
      method: 'POST'
      data:
        id: id
      dataType: 'json'
    }
    .done (data) ->
      b.animate({opacity: 1});
      $('.gallery-item[data-id=' + id + ']').remove()
      if $('.gallery-item').length == 0
        $('.gallery-item-new').trigger('click')
      else
        $('.gallery-item').last().find('.picture').trigger('click')
    .fail ->
      alert('Houve um problema ao remover a imagem')

  $remix.find('.create-new, .gallery-item-new, .start-over').click ->
    $remix.trigger 'init'

  $composer.find('.cancel').click ->
    $remix.trigger 'finish'

  $composer.find('.actions .next').click ->
    $remix.trigger 'publish'

  $composer.find('.publish').click ->
    $remix.trigger 'share'

  $composer.find('.toolbox .categories .take-photo input').change ->
    file = this.files[0];
    reader = new FileReader()
    reader.addEventListener 'load', ->
      $remix.trigger 'set-picture', reader.result
      $remix.trigger 'compose'
      rotateImage file

    if file
      reader.readAsDataURL file

  $composer.find('.toolbox .categories').on 'click', '.item[data-id]', ->
    $remix.trigger 'choose-picture', $(this).data('id')

  $composer.find('.toolbox .pictures .go-back').click ->
    $remix.trigger 'init'

  $composer.find('.toolbox .pictures').on 'click', '.item[data-picture-src]', ->
    $remix.trigger 'set-picture', $(this).data('picture-src')
    $remix.trigger 'compose'

  # toggles between tools
  $composer.find('.toolbox .toggler').click ->
    if $remix.hasClass('can-compose') && !$(this).parent().hasClass('category')
      $(this)
        .closest('.toolbox-item').trigger('remix:toolbox-click')
        .siblings('.toolbox-item-popup').removeClass('on')
      $remix.removeClass('can-choose-picture')

  # toolbox item color
  $composer.find('.toolbox-item-colors').on 'remix:toolbox-click', ->
    if !DATA_BGS.length
      alert 'Nenhuma cor disponível'
      return

    index = $remix.data('colors-index') || 0
    if index >= DATA_BGS.length
      index = 0

    $canvas.css('background-color', DATA_BGS[index].color)
    $remix.data('colors-index', index+1)

  # toolbox item effects
  $composer.find('.toolbox-item-effects').on 'remix:toolbox-click', ->
    index = $remix.data('effects-index') || 0
    if index >= DATA_CSS_EFFECTS.length
      index = 0

    $canvas.find('.picture').css(DATA_CSS_EFFECTS[index])
    $remix.data('effects-index', index+1)

  # toolbox item popup
  $composer.find('.toolbox-item-popup').on 'remix:toolbox-click', ->
    $(this).closest('.toolbox-item')
      .toggleClass('on')

  # toolbox item elements item
  $composer.find('.toolbox-item-elements .elements').on 'click', '.elements-item', (event) ->
    if $(this).hasClass('pattern')
      if $('.remix-canvas').find('.pattern').length == 0
        $('.remix-canvas').prepend('<img src="" class="pattern" style="width: 100%; height: 100%; position: absolute; z-index: 0; opacity: 0" crossorigin="anonymous" />');
      $('.remix-canvas').find('.pattern').attr('src', $(this).data('src')).css({opacity: 1});
      return
    event.stopPropagation()
    $remix
      .trigger('add-image', $(this).data('src'))
      .data('last-element').trigger('remix:select-element')

    if window.isMobile()
      $(this).closest('.toolbox-item').removeClass('on')

  # toolbox item texts colors
  $composer.find('.toolbox-item-texts .color-palette button').click ->
    if !DATA_TXT_COLORS.length
      alert 'Nenhuma cor disponível'
      return

    $text = $canvas.find('.text.focus')
    index = $remix.data('text-colors-index') || 0
    if index >= DATA_TXT_COLORS.length
      index = 0
    $remix.data('text-colors-index', index+1)
    color = DATA_TXT_COLORS[index].background

    $composer.find('.toolbox-item-texts .styles-item').each ->
      stylesObj = {
        'box-shadow': ''
        'text-shadow': ''
        'color': ''
      }

      if $(this).hasClass('g1') || $(this).hasClass('m1') || $(this).hasClass('p1')
        stylesObj['background-color'] = color

        if color == '#FFFFFF' || color == '#FFF'
          stylesObj['box-shadow'] = '0 0 2px #000'
          stylesObj.color = '#000'
      else
        stylesObj.color = DATA_TXT_COLORS[index].background

        if color == '#FFFFFF' || color == '#FFF'
          stylesObj['text-shadow'] = '0 0 2px #000'

      $(this)
        .css(stylesObj)
        .data('styles', stylesObj)

    if $text.length
      if $text.hasClass('g1') || $text.hasClass('m1') || $text.hasClass('p1')
        $text.css('background-color', DATA_TXT_COLORS[index].background)
      else
        $text.css('color', DATA_TXT_COLORS[index].foreground)

  # toolbox item texts styles
  $composer.find('.toolbox-item-texts .styles-item').click (event) ->
    event.stopPropagation()
    $remix
      .data('text-color', $(this).data('styles'))
      .trigger('add-text', $(this).data('class'))
      .data('last-element').trigger('remix:select-element')
      .find('textarea').attr('readonly', false)

    if window.isMobile()
      $(this).closest('.toolbox-item').removeClass('on')

  # canvas
  $canvas.on 'click', ->
    $(this).find('.element').trigger('remix:deselect-element')

  # shares
  $composer.find('.share .networks a').click (event) ->
    window.open($(this).attr('href'), '', 'width=600,height=600')
