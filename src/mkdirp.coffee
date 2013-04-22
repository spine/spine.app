fd = require('path')
fs = require('fs')

mkdirp = module.exports = (path, mode = 0o0775) ->
  path = fd.resolve(path)
  unless fs.existsSync(path)
    try
      fs.mkdirSync(path, mode)
    catch err
      mkdirp(fd.dirname(path), mode)
      fs.mkdirSync(path, mode)
