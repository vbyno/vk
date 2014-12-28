'use strict'

class Vk.Pages.ApartmentPage
  @shouldBeExecuted: ->
    $('body').hasClass 'apartments show'

  constructor: ->
    new Vk.Forms.ReservationForm()
    $('.carousel').carousel()

jQuery ->
  new Vk.Pages.ApartmentPage() if Vk.Pages.ApartmentPage.shouldBeExecuted()
