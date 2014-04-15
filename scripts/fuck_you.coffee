module.exports = (robot) ->
  robot.hear /Fuck you,? Bort/i, (msg) ->
    msg.send "Fuck you too, #{msg.envelope.user.name}! <3"

  robot.hear /.*?bort.*?you're drunk.*?/i, (msg) ->
    msg.send "NO #{msg.envelope.user.name.toUpperCase()}, UR DRINK!!!1!ONE1!!"
