#= require tinymce

'use strict'

class Vk.Forms.ApartmentForm
  @newWith: (html) ->
    $('#apartment-form').html(html)
    new Vk.Forms.ApartmentForm()

  constructor: ->
    $('button').lazyButton()
    tinyMCE.init
      selector: '.tinymce'
      toolbar: 'sizeselect | bold italic | fontselect |  fontsizeselect'

  successNotification: ->
    $('#apartment-form').prepend(
      "<div class='alert alert-info'>Success!</div>"
      )
