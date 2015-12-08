##Introduction

Effortlessly generate [Spine](http://github.com/spine/spine), [CoffeeScript](http://jashkenas.github.com/coffee-script) and [Hem](https://github.com/spine/hem) applications. Spine.App gives hooks your application up with some structure, CommonJS modules, and gives you some nice tools to help it grow.

##Usage

First step is to install the [npm](http://npmjs.org/) package. If you don't already have [npm](http://npmjs.org/) or [NodeJS](http://nodejs.org/) you'll need to install them first.

    $ npm install -g spine.app

Then we can generate the initial application structure like this:

    $ spine app my_app

Now we've produced a directory structure looking like:

    my_app/.gitignore
    my_app/.npmignore
    my_app/Procfile
    my_app/app
    my_app/app/controllers
    my_app/app/index.coffee
    my_app/app/lib
    my_app/app/lib/setup.coffee
    my_app/app/models
    my_app/app/views
    my_app/app/views/sample.jade
    my_app/css
    my_app/css/index.styl
    my_app/css/mixin.styl
    my_app/lib
    my_app/lib/jade_runtime.js
    my_app/lib/jquery.js
    my_app/package.json
    my_app/public
    my_app/public/favicon.ico
    my_app/public/index.html
    my_app/slug.coffee
    my_app/test
    my_app/test/specs

First let's navigate to our application, and install it's npm dependencies:

    $ cd my_app
    $ npm install .

These will be exported locally in the `./npm_modules` folder. Now, let's install [Hem](http://github.com/spine/hem), which will be in charge or bundling our application.

    $ npm install -g hem

And to serve our application up:

    $ hem server

This will boot up an server on port [9294](http://localhost:9294). You can now start generating Spine controllers and models:

    $ spine controller users
        app/controllers/users.coffee

    $ spine model user
        app/models/user.coffee

Any application specific code should go in the `app` folder. Otherwise, generic code, should go in the `lib` folder.

Any [CoffeeScript](http://jashkenas.github.com/coffee-script), [Stylus](http://learnboost.github.com/stylus/), or [Jade](https://github.com/visionmedia/jade) templates files inside the application will be automatically compiled when requested, you don't need to worry about compiling them manually. That is Hem's magic happening.

Hem will also bundle up all your JavaScript files, enclosing them in a CommonJS wrapper. This means that scripts in the `app` folder need to be CommonJS compliant (basically exactly like normal Node scripts). In other words, to use a module you'll need to `require()` it, and you'll need to explicitly export any global variables.

    Guide = require("controllers/guide")

    class App extends Spine.Controller
      elements:
        "#item": "item"

      init ->
        @guide = new Guide(el: @item)

    # Explicitly export it
    module.exports = App

Inside your HTML files, you need only require *application.js* and every module will be wrapped up and ready to be loaded. As you can see, the generated *index.html* kicks things off by instantiating *app/app.coffee* when the page loads.

    var exports = this;
    jQuery(function(){
      var App = require("app");
      exports.App = new App({el: $("#body")});
    });
