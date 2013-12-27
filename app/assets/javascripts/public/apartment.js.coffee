#= require bxslider.min

'use strict'

jQuery ->
  $('.bxslider').bxSlider
    minSlides: 3
    maxSlides: 3
    infiniteLoop: false
    hideControlOnEnd: false
    slideMargin: 10
    slideWidth: 0
    responsive: true
    controls: true
    pager: false
    moveSlides: 1
    adaptiveHeight: false
