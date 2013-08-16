# Description:
#   Let people know where you are
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot i'm at <string> - store your current location
#   hubot where is <string> - returns the user's location
#   hubot i'm out
#
# Author:
#   shipstar

getAmbiguousUserText = (users) ->
    "Be more specific, I know #{users.length} people named like that: #{(user.name for user in users).join(", ")}"

module.exports = (robot) ->
  robot.respond /i'm at (.*)/i, (msg) ->
    userName = msg.envelope.user.name
    location = msg.match[1].trim()
    robot.brain.set "location:#{userName}", location
    msg.reply "You're at #{location}. Got it."

  robot.respond /where'?(?:\si)?s (\w*)(?:\?)?/i, (msg) ->
    name = msg.match[1].trim()

    users = robot.brain.usersForFuzzyName(name)
    if users.length is 1
      user = users[0]
      if location = robot.brain.get("location:#{user.name}")
        msg.send "#{user.name} is at " + location
      else
        msg.send "#{user.name} is in the wind..."
    else if users.length > 1
      msg.send getAmbiguousUserText users
    else
      msg.send "#{name}? Never heard of 'em"

  robot.respond /where am i\??/i, (msg) ->
    userName = msg.envelope.user.name

    if location = robot.brain.get("location:#{userName}")
      msg.reply "You're at #{location}"
    else
      msg.reply "You're in the wind..."

  robot.respond /i'm out/i, (msg) ->
    userName = msg.envelope.user.name

    robot.brain.remove "location:#{userName}"
    msg.reply "You're in the wind..."
