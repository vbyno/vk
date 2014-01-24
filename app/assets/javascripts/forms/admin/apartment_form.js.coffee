'use strict'

class Vk.Forms.ApartmentForm
  @newWith: (html) ->
    $('#apartment-form').html(html)
    new Vk.Forms.ApartmentForm()

  constructor: ->
    $('apartment_submit_action').lazyButton()

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
      send: (e, data) ->
        data.my_id = data.files[0].size
        $("#photos tr:last").after(
          $("<tr>
              <td>#{data.files[0].name}</td>
              <td>
                <div id='#{data.my_id}' class='progress progress-striped active'>
                  <div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='0' aria-valuemin='0' aria-valuemax='100' style='width: 0%'></div>
                </div>
              </td>
              <td></td>
              <td></td>
            </tr>"))
      progress: (e, data) ->
        progress = parseInt(data.loaded / data.total * 100, 10)
        $("##{data.my_id} .progress-bar").css 'width', "#{progress}%"
      done: (e, data) ->
        photo = data.result
        row = $("<td><image src='#{photo.url}' width='80'></td>
                 <td></td>
                 <td></td>
                 <td></td>")
        $("##{data.my_id}").closest('tr').html(row)

  successNotification: ->
    $('#apartment-form').prepend(
      "<div class='alert alert-info'>Success!</div>"
      )
