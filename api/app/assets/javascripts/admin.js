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
//= require jquery-ui/ui/version
//= require jquery-ui/ui/plugin
//= require jquery-ui/ui/data
//= require jquery-ui/ui/scroll-parent
//= require jquery-ui/ui/widget
//= require jquery-ui/ui/widgets/mouse
//= require jquery-ui/ui/widgets/sortable
//= require "redactor"
//= require masonry.pkgd
//= require bootstrap
//= require_self

$(document).ready(function() {
    resizeAdminContent();
    updateStatusToggle();

    var overlay = $('.overlay'),
        filterList = $('.btn-filter .item ul'),
        filterItem = $('.btn-filter .item'),
        filterSelectAllCards = $('.action-bar a.select-all'),
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

    $('body').on('click', '.card', function() {
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
                $('#new_card').attr('action', '/admin/moderator/' + action);
                $('#new_card')[0].submit();
            }
        }
    });

    $('input.search').on('keyup', function() {
        var context = $(this).val().toLowerCase();
        cardsContainer.find('.card').each(function() {
            var contentText = $(this).find('.card-content p.text').text().toLowerCase();
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

    $(".switch .checkbox input[type='checkbox']").change(function() {
        updateStatusToggle();
    });

    $("#highlights .bottom-content").sortable({
        stop: function(event, ui) {
            var elem = $(ui.item);
            $.post("/admin/highlights/" + elem.find('[data-highlight-id]').attr('data-highlight-id') + "/move", { to: elem.index() + 1 });
        }
    });

    $('.submit-highlight').click(function() {
        $('#input-preview').val("0");
        $('#highlight-form').submit();
    });

    $('#preview-button').click(function() {
        $('#input-preview').val("1");
        $(".switch .checkbox input[type='checkbox']").prop("checked", false);
        $('#highlight-form').submit();
    });

    setTimeout(function() { initMasonry(); }, 1000);

    tinymce.init({
        selector:'.redactor textarea',
        height: 500,
        theme: 'modern',
        plugins: [
            'template advlist autolink lists link image preview hr anchor pagebreak',
            'searchreplace visualchars code fullscreen',
            'insertdatetime media nonbreaking table contextmenu',
            'paste textcolor colorpicker textpattern imagetools toc'
        ],
        toolbar1: 'undo redo | insert | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image',
        toolbar2: 'template media | forecolor backcolor',
        removed_menuitems: 'newdocument',
        // templates: [
        //     {title: 'Versão Original', description: 'HTML original da página', url: 'http://cdn.tmjofilme.com.br/tudosobretmj/template.html'}
        // ],
        file_picker_callback: function(callback, value, meta) {
          if (meta.filetype == 'image') {
            $('#upload').trigger('click');
            $('#upload').on('change', function() {
              var file = this.files[0];
              var reader = new FileReader();
              reader.onload = function(e) {
                callback(e.target.result, {
                  alt: ''
                });
              };
              reader.readAsDataURL(file);
            });
          }
        }
    });

    $('.editors-sub').on('click', '[data-revoke-editor]', function(e) {
        e.preventDefault();
        e.stopPropagation();
        var $this = $(this),
            container = $this.parents('li');

        container.slideUp();

        $.ajax({
            url: '/admin/editors/revoke',
            method: 'POST',
            data: {
                id: $this.attr('data-revoke-editor')
            },
            json: true,
            success: function(data) {
                if(data.success) {
                    $this.remove();
                    window.location = '/admin/editors';
                } else {
                    alert('Houve um problema ao rebaixar o editor.')
                    container.slideDown();
                }
            },
            error: function() {
                alert('Houve um problema ao rebaixar o editor.')
                container.slideDown();
            }
        });
    });

    (function() {
        var nef = $('#new-editor-field');
        var commitNewEditor = function() {
            if(nef.val().trim() === '') {
                return;
            }
            $.ajax({
                url: '/admin/editors/promote',
                method: 'POST',
                data: {
                    username: nef.val()
                },
                success: function(data) {
                    var el = $(data);
                    $('.editor-list').append(el);
                    el.slideDown();
                    nef.val('');
                },
                error: function() {
                    alert('Não foi possível promover o usuário fornecido. Certifique-se de que ele está correto.');
                }
            })
        }
        $('#promote-user-commit').on('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            commitNewEditor();
        });
    })();
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

function updateStatusToggle() {
    if ($(".switch .checkbox input[type='checkbox']").prop("checked") == true) {
        $(".slider").addClass('checked');
    } else {
        $(".slider").removeClass('checked');
    }
}

function resizeAdminContent() {
    $('section .bottom-content').css('height', $('.admin-content').height() - 205);
    $('section .content').css('height', $(window).height() - 205);
};

// On window resize
$(window).resize(function() {
    resizeAdminContent();
});
