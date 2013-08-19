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

unknownLocations = [
  "in the wind...",
  "AWOL.",
  "in the ether, man!",
  "fighting commies somewhere.",
  "AFK.",
  "out. Don't pout.",
  "gone fishin'.",
  "taking a long walk off a short pier."
]

getAmbiguousUserText = (users) ->
    "Be more specific, I know #{users.length} people named like that: #{(user.name for user in users).join(", ")}"

module.exports = (robot) ->
  robot.respond /i(?:'?|\s?a?)m (at|in) (.*)/i, (msg) ->
    userName = msg.envelope.user.name
    location = "#{msg.match[1].trim()} #{msg.match[2].trim()}"
    robot.brain.set "location:#{userName}", location
    msg.reply "You're #{location}. Got it."

  robot.respond /where'?(?:\si)?s (\w*)(?:\?)?/i, (msg) ->
    name = msg.match[1].trim()

    users = robot.brain.usersForFuzzyName(name)
    if users.length is 1
      user = users[0]
      if location = robot.brain.get("location:#{user.name}")
        msg.send "#{user.name} is " + location
      else
        msg.send "#{user.name} is #{msg.random unknownLocations}"
    else if users.length > 1
      msg.send getAmbiguousUserText users
    else
      msg.send "#{name}? Never heard of 'em"

  robot.respond /where am i\??/i, (msg) ->
    userName = msg.envelope.user.name

    if location = robot.brain.get("location:#{userName}")
      msg.reply "You're #{location}"
    else
      msg.reply "You're #{msg.random unknownLocations}"

  robot.respond /i'm out/i, (msg) ->
    userName = msg.envelope.user.name

    robot.brain.remove "location:#{userName}"
    msg.reply "You're #{msg.random unknownLocations} Got it."
