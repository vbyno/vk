#= require bxslider
#= require bootstrap-image-gallery.min

'use strict'

jQuery ->
  $('.datepicker').custom_datepicker()
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
