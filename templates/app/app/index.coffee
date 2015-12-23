require('lib/setup')

Spine = require('spine')

class App extends Spine.Controller
  constructor: ->
    super
    # Getting started - should be removed
    console.log('taking a peek under the hood, eh?! good for you!')
    @html require("views/sample")({version:Spine.version})

module.exports = App
