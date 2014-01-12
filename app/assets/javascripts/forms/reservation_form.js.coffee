#= require bootstrap-datepicker

'use strict'

class Vk.Forms.ReservationForm
  constructor: ->
    $('.datepicker').datepicker
      format: 'dd/mm/yyyy'
      startDate: '0d'
      language: $('html').attr('lang')
      autoclose: true
    $('button').lazyButton()
