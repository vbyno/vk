#= require active_admin/base
#= require tinymce
#= require turbolinks
#= require jquery.turbolinks

jQuery ->
  tinyMCE.init
    selector: '.tinymce'
    toolbar: 'sizeselect | bold italic | fontselect |  fontsizeselect'
    content_css : '/assets/tinymce'
