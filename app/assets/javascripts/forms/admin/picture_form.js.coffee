'use strict'

class Vk.Forms.PictureForm
  @shouldBeExecuted: ->
    $('body').hasClass('admin pages edit')

  constructor: ->
    $submitBtn = $('#picture_submit_action')

    $submitBtn.lazyButton()

    $('#add-picture').on 'click', ->
      $('#picture_image').click()
      false

    $("#new_picture").fileupload
      dataType: 'json'
      maxFileSize: 5000000
      acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i
      add: (e, data) ->
        $submitBtn.click (event) ->
          data.submit()
          event.preventDefault()
      done: (e, data) ->
        # TODO make proxy: picture form should not know about tinymce
        picture = data.result
        $('#picture-modal').modal('hide')
        tinyMCE.activeEditor.execCommand('mceInsertContent',
                                         false, "<p>#{picture.title}</p>")

jQuery ->
  new Vk.Forms.PictureForm() if Vk.Forms.PictureForm.shouldBeExecuted()

