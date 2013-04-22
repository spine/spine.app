fs     = require('fs')
fd     = require('path')
mkdirp = require('./mkdirp')
ansi   = require('./ansi')

isDir = (path) ->
  fs.statSync(path).isDirectory()

class Template 
  constructor: (@template, @path, @values = {}) ->
    
  files: ->
    return [ @template ]  unless isDir(@template)
    files = []
    next = (dir) ->
      for file in fs.readdirSync(dir)
        files.push(file = "#{dir}/#{file}")
        next(file) if isDir(file)
    next @template
    files
    
  @::__defineGetter__ 'files', @::files
  
  write: ->
    mkdirp fd.dirname(@path)
    for path in @files
      out = path.replace(@template, '')
      out = fd.join(@path, out)
      out = fd.normalize(out)
      if isDir(path)
        fs.mkdirSync out, 0o0775
        console.log ansi("\tcreate\t", 'green'), out
      else if fs.existsSync(out)
        throw ("#{path} already exists")
      else
        data = @parse(fs.readFileSync(path, 'utf8'))
        fs.writeFileSync out, data
        console.log ansi("\tcreate\t", 'green'), out
        
  parse: (data) ->
    data.replace /\{\{([^}]+)\}\}/g, (_, key) =>
      @values[key]
      
module.exports = Template
