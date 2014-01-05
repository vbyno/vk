#= require bootstrap-datepicker

$.fn.custom_datepicker = ->
  this.datepicker
    format: 'dd/mm/yyyy'
    startDate: '0d'
    language: $('body').data('locale')
    autoclose: true