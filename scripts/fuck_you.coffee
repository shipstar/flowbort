
hated_people = [
  'mitch'
]

module.exports = (robot) ->
  robot.hear /Fuck you,? Bort/i, (msg) ->
    msg.send "Fuck you too, #{msg.envelope.user.name}! <3"

  robot.hear /.*?bort.*?you're drunk.*?/i, (msg) ->
    msg.send "NO #{msg.envelope.user.name.toUpperCase()}, UR DRINK!!!1!ONE1!!"

  robot.hear /i (.+?)( you,?)? bort/i, (msg) ->
    if (hated_people.filter (name) -> name.toLowerCase() == msg.envelope.user.name.toLowerCase()).length > 0
      msg.send "http://media3.giphy.com/media/qVBNXg7jIIYCs/giphy.gif"
    else
      msg.send "I #{msg.match[1]} you too, #{msg.envelope.user.name}!"
