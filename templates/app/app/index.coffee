require('lib/setup')

Spine = require('spine')

class App extends Spine.Controller
  constructor: ->
    super
    # Getting started - should be removed
    @html '<h2>Welcome to Spine.js</h2><p>Time to get busy!</p>'

module.exports = App
