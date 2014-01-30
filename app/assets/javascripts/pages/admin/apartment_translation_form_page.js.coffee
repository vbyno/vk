'use strict'

class Vk.Pages.ApartmentTranslationFormPage
  @shouldBeExecuted: ->
    $body = $('body')
    $body.hasClass('admin apartment_translations edit') ||
      $body.hasClass('admin apartment_translations new')

  constructor: ->
    new Vk.Forms.ApartmentTranslationForm()

jQuery ->
  if Vk.Pages.ApartmentTranslationFormPage.shouldBeExecuted()
    new Vk.Pages.ApartmentTranslationFormPage()
