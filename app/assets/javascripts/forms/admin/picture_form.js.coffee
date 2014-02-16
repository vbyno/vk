'use strict'

class Vk.Forms.PictureForm
  @shouldBeExecuted: ->
    $('body').hasClass('admin pages edit')

  @newWith: (html) ->
    $('#picture-form-wrapper').html(html)
    new Vk.Forms.PictureForm()

  @clean: ->
    $('#picture-form-wrapper').empty()

  @showModal: ->
    $('#picture-modal').modal('show')

  @hideModal: ->
    $('#picture-modal').modal('hide')

  constructor: ->
    $submitBtn = $('#picture_submit_action')

    $submitBtn.lazyButton()

    $('#add-picture').on 'click', ->
      $('#picture_image').click()
      false

    $("#new_picture").fileupload
      dataType: 'script'
      maxFileSize: 5000000
      acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i
      add: (e, data) ->
        $submitBtn.click (event) ->
          data.submit()
          event.preventDefault()
