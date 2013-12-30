#= require bxslider
#= require bootstrap-image-gallery.min
#= require bootstrap-datepicker

'use strict'

jQuery ->
  locale = $('body').data('locale')
  # TODO think about better way

  $('.datepicker').datepicker
    format: 'dd/mm/yyyy'
    startDate: '0d'
    language: locale

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
