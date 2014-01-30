this.module = (name) ->
  this[name] = this[name] or {}

module 'Vk'
module.apply(Vk, ['Forms'])
module.apply(Vk, ['Pages'])
module.apply(Vk, ['Helpers'])
