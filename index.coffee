# use v8 stack magic to get the location of the calling script
# this helped -> http://stackoverflow.com/questions/13227489/how-can-one-get-the-file-path-of-the-caller-function-in-node-js
# but it's mostly stack magic
getCallerFilename = () ->
  oP = Error.prepareStackTrace
  Error.prepareStackTrace = (e,stack) ->
    return stack
  err = new Error()
  stack = err.stack
  Error.prepareStackTrace = oP
  stack.shift()
  stack.shift()
  return stack[1].receiver.filename

module.exports = (modules...)->
  callerFile = getCallerFilename()
  callerDirectory = require('path').dirname(callerFile)
  if modules.length == 0
    mods = {}
    for modFile in require('fs').readdirSync(callerDirectory).filter((elem)-> return elem.substr(elem.length-3,elem.length) == '.js' and callerFile != callerDirectory+"\\"+elem)
      mod = modFile.substr(0,modFile.length-3)
      mods[mod] = require callerDirectory+"/"+mod
    return mods
  else
    mods = {}
    for mod in modules
      mods[mod] = require mod
    return mods

