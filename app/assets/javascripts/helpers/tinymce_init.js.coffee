'use strict'

Vk.Helpers.tinymceInit = ->
  tinyMCE.init
    selector: '.tinymce'
    content_css: '/css/tinymce_content.css'
    plugins: "advlist autolink lists link image charmap print preview hr anchor
              pagebreak searchreplace wordcount visualblocks visualchars code
              fullscreen insertdatetime media nonbreaking save table contextmenu
              directionality emoticons template paste textcolor"
    toolbar: "insertfile undo redo | styleselect | bold italic | alignleft
              aligncenter alignright alignjustify | bullist numlist outdent
              indent | link image print preview media | forecolor backcolor
              emoticons | add_photo"
    image_advtab: true
    templates: [
        {title: 'Test template 1', content: 'Test 1'},
        {title: 'Test template 2', content: 'Test 2'}
    ]
    setup: (editor) ->
      editor.addButton 'add_photo',
        text: 'Add Photo',
        icon: false,
        onclick: ->
          $('#picture-modal').modal()
