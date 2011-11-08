CODES =
  off: 0
  red: 31
  green: 32
  yellow: 33

ansi = module.exports = (message, color = 'green') ->
  str = ''
  str += "\u001b[" + CODES[color] + 'm'
  str += message
  str += "\u001b[" + CODES['off'] + 'm'
  str