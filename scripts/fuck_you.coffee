module.exports = (robot) ->
  robot.hear /Fuck you,? Bort/i, (msg) ->
    msg.send "Fuck you too, #{msg.envelope.user.name}! <3"
