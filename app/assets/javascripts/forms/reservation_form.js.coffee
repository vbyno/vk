'use strict'

class Vk.Forms.ReservationForm
  constructor: ->
    $('.datepicker').datepicker
      format: 'dd/mm/yyyy'
      startDate: '0d'
      language: $('html').attr('lang')
      autoclose: true
    $(".phone-mask").mask("+99 (999) 999-99-99")
    $(".date-mask").mask("99/99/9999")
    $('button').lazyButton()
