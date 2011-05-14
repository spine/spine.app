#!/usr/bin/env node
var stitch  = require('stitch'),
    express = require('express'),
    util    = require('util'),
    argv    = process.argv.slice(2);

var package = stitch.createPackage({
  paths: [__dirname + '/lib', __dirname + '/app'],
  dependencies: [
    __dirname + '/lib/json2.js',
    __dirname + '/lib/shim.js',
    __dirname + '/lib/jquery.js',
    __dirname + '/lib/jquery.tmpl.js',
    __dirname + '/lib/spine.js',
    __dirname + '/lib/spine.tmpl.js',
    __dirname + '/lib/spine.manager.js',
    __dirname + '/lib/spine.model.ajax.js',
    __dirname + '/lib/spine.model.local.js',
    __dirname + '/lib/spine.route.js'
  ]
});

var app = express.createServer();

app.configure(function() {
  app.set('views', __dirname + '/views');
  app.use(express.compiler({ src: __dirname + '/public', enable: ['less'] }));
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
  app.get('/application.js', package.createServer());
});

var port = argv[0] || 9294;
util.puts("Starting server on port: " + port);
app.listen(port);