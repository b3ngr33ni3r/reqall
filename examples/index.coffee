
# load all the js modules in this directory [ie, hello.js, world.js, AND index.js (self)]
# in your code, the ../index would be reqall
modules = require('../index')()
console.log modules # show our modules object

modules.hello()
console.log modules.world

# now you'd think that we could access the current scripts module.exports using this:
module.exports = () ->
  console.log "how interesting"

# but we actually can't, due to how node works. since the script is still executing,
# it fails, so  i've removed that functionality so you don't get confusing values
# there.
# a call to modules.index() WOULD FAIL HERE