'use strict'

class Vk.Pages.ApartmentFormPage
  @shouldBeExecuted: ->
    $body = $('body')
    $body.hasClass('admin apartments edit') || $body.hasClass('admin apartments new')

  constructor: ->
    new Vk.Forms.ApartmentForm()

jQuery ->
  new Vk.Pages.ApartmentFormPage() if Vk.Pages.ApartmentFormPage.shouldBeExecuted()
