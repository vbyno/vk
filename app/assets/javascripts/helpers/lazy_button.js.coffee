$.fn.lazyButton = ->
  $this = $(this)
  $this.on 'click', ->
    $this.button 'loading'
