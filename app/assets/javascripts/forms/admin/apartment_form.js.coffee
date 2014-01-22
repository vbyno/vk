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

    $('#add-photos').on 'click', ->
      $('#photo_image').click()
      false

    $("#new_photo").fileupload
      dataType: 'json'
      maxFileSize: 5000000
      acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i

  successNotification: ->
    $('#apartment-form').prepend(
      "<div class='alert alert-info'>Success!</div>"
      )
