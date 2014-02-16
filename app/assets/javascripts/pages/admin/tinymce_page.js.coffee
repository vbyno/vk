'use strict'

class Vk.Pages.TinyMCEPage
  @shouldBeExecuted: ->
    $body = $('body')
    $body.hasClass('admin pages edit') ||
      $body.hasClass('admin pages new') ||
      $body.hasClass('admin apartment_translations edit') ||
      $body.hasClass('admin apartment_translations new')

  constructor: ->
    Vk.Helpers.tinymceInit()

jQuery ->
  if Vk.Pages.TinyMCEPage.shouldBeExecuted()
    new Vk.Pages.TinyMCEPage()