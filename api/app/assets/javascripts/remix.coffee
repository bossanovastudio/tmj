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

API_URL = '/api/remix'
DATA_BGS = []
DATA_TXT_COLORS = []
DATA_CSS_EFFECTS = [
  {
    '-webkit-filter': 'grayscale(1)',
    'filter': 'grayscale(1)'
  }
  {
    '-webkit-filter': 'sepia(1)',
    'filter': 'sepia(1)'
  }
  {
    '-webkit-filter': 'sepia(1) hue-rotate(200deg)',
    'filter': 'sepia(1) hue-rotate(200deg)'
  }
  {
    '-webkit-filter': 'contrast(1.4) saturate(1.8) sepia(.6)',
    'filter': 'contrast(1.4) saturate(1.8) sepia(.6)'
  }
  {
    '-webkit-filter': 'none',
    'filter': 'none'
  }
]

window.isMobile = ->
  return $(window).width() < 768

window.isDesktop = ->
  return $(window).width() >= 768

# toDataURL = (src, callback, outputFormat) ->
#   xhr = new XMLHttpRequest()
#   xhr.onload = ->
#     url = URL.createObjectURL this.response
#     img = new Image()
#     img.crossOrigin = 'Anonymous'
#     img.onload = ->
#       canvas = document.createElement 'CANVAS'
#       ctx = canvas.getContext '2d'
#       canvas.height = this.height
#       canvas.width = this.width
#       ctx.drawImage this, 0, 0
#       dataURL = canvas.toDataURL outputFormat
#       callback dataURL

#       URL.revokeObjectURL url
#     img.src = url

#     if img.complete?
#       img.src = 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==';
#       img.src = url

#   xhr.open 'GET', src, true
#   xhr.responseType = 'blob'
#   xhr.send()

# toDataURL 'http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/3/foto-3.png', (base64) ->
#   console.log base64
# , 'image/png'

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
    template = '<div class="item" data-id="{{ id }}"><div><img src="{{ &url }}" alt="{{ name }}"></div></div>'
    Mustache.parse template

    result.categories.forEach (category) ->
      html += Mustache.render template, category

    $composer.find('.toolbox-item.category .categories').append(html)

    # pictures
    html = ''
    template = '<div class="item" data-category-id="{{ category_id }}" data-picture-src="{{ &url }}"><div><img src="{{ &url }}" alt=""></div></div>'
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
    template = '<div class="elements-item" data-src="{{ &url }}"><img src="{{ &url }}" alt=""></div>'
    Mustache.parse template

    result.balloons.forEach (balloon) ->
      html += Mustache.render template, balloon

    $composer.find('.toolbox-item.balloons .elements').append(html)

    # stickers
    html = ''
    template = '<div class="elements-item" data-src="{{ &url }}"><img src="{{ &url }}" alt=""></div>'
    Mustache.parse template

    result.stickers.forEach (sticker) ->
      html += Mustache.render template, sticker

    $composer.find('.toolbox-item.stickers .elements').append(html)

    # text colors
    if result.text_colors?
      DATA_TXT_COLORS = result.text_colors.filter (color) ->
        return (color.background != '#000000' && color.background != '#000')

    DATA_TXT_COLORS.push { foreground: '#000000', background: '#000000' }

    # hides loading
    $loader.fadeOut 400, ->
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

      # selects the holder of picture
      $composer.find('.toolbox .toolbox-item.category .pictures .item[data-category-id="' + id + '"]')
        .addClass('on')
        .siblings('.item').removeClass('on')

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

      # generates base64 image (with canvas)
      # docs: http://html2canvas.hertzen.com/documentation.html
      html2canvas $canvas.get(0), {
        useCORS: true
        onrendered: (canvas) ->
          base64Image = canvas.toDataURL('image/png')
          $canvas.html('<img src="' + base64Image + '" alt="">')

          # TODO: replace with true url
          # $.ajax {
          #   url: API_URL + '/create'
          #   data:
          #     image: base64Image
          #   dataType: 'json'
          # }
          # .done (data) ->
          #   $canvas.html('<img src="' + data.image_url + '" alt="">')
          # .fail ->
          #   alert 'Não foi possível salvar a imagem'
      }

      # BEGIN: to save in back-end, use these lines below
      # output = {
      #   elements: []
      # }

      # $canvas.children().each ->
      #   output.elements.push {
      #     type: $(this).attr('class')
      #     src: $(this).attr('src')
      #     x: $(this).position().left
      #     y: $(this).position().top
      #     z: $(this).index()
      #     w: $(this).width()
      #     h: $(this).height()
      #   }
      # END: to save in back-end
      # console.log 'output json', output

    # finish state
    'finish': ->
      $(this).trigger('reset').removeClass('initial')

    # sets picture element to the artboard and hides empty message
    'set-picture': (event, src) ->
      $picture = $canvas.find('.picture')

      if !$picture.length
        $picture = $('<div>')
        $canvas.append $picture

      $picture
        .css { 'background-image': 'url(' + src + ')' }
        .attr { class: 'picture' }

      $composer.find('.artboard .empty').hide()

    # sets picture element to the artboard and hides empty message
    'add-image': (event, src) ->
      $element = $('<div>').attr { class: 'element image' }

      $('<img>').attr { src: src, alt: '' }
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
          $hidden = $(this).siblings('.hidden-content')
          $hidden.html(this.value.replace(/\n/g, '<br>'))

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

    $(this).find('.gallery-item').find('.picture, .actions .share').click ->
      $item = $(this).closest('.gallery-item')
      $image = $(this).closest('.gallery-item').find('.picture').clone()
      $image.appendTo($canvas)

      $composer.find('.artboard .empty').hide()
      $composer.find('.actions .download').attr('href', $image.attr('src'))
      $composer.find('.actions .remove').data('id', $item.data('id'))
      $remix.addClass('initial can-share')

  $(window).resize ->
    $gallery.trigger 'remix:gallery-adapt'

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
