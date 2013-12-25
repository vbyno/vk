#= require bxslider.min

'use strict'

jQuery ->
  $('.bxslider').bxSlider
    minSlides: 2
    maxSlides: 3
    infiniteLoop: false
    hideControlOnEnd: false
    slideMargin: 0
    slideWidth: 400
    responsive: true
    controls: true
    pager: false
    moveSlides: 1
