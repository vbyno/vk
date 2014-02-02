'use strict'

class Vk.Pages.ApartmentPage
  @shouldBeExecuted: ->
    $('body').hasClass 'apartments show'

  constructor: ->
    new Vk.Forms.ReservationForm()

    $('.bxslider').bxSlider
      minSlides: 3
      maxSlides: 3
      infiniteLoop: false
      hideControlOnEnd: true
      slideMargin: 10
      slideWidth: 0
      responsive: true
      controls: true
      pager: false
      moveSlides: 1
      adaptiveHeight: false
      startSlide: 0

jQuery ->
  new Vk.Pages.ApartmentPage() if Vk.Pages.ApartmentPage.shouldBeExecuted()
