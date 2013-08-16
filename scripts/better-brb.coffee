# Description:
#   Natural availability tracking, but better.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   brb (or afk, or bbl)
#
# Author:
#   tonydewan
#   based on brb by jmhobbs

_ = require('underscore')

module.exports = (robot) ->

  away_triggers = ['brb', 'afk', 'bbl']

  robot.hear /./i, (msg) ->
    if robot.brain.get("away:#{msg.message.user.name}") and !_.contains(away_triggers, msg.message.text)
      msg.send "Welcome back " + msg.message.user.name + "!"
      robot.brain.remove "away:#{msg.message.user.name.toLowerCase()}"
    else
      _.each robot.brain.users(), (user) ->
        # only if the message starts with the name
        # so hubot doesn't tell you they aren't there every time you mention someone
        if msg.message.text.match new RegExp("^@?#{user.name}", 'i')
          msg.send user.name + " is currently away."

  robot.respond /is @?(\w*)\s?(?:actually|definitely|really|rly)? (?:t?here|away)/i, (msg) ->
    if robot.brain.get "away:#{msg.match[1].toLowerCase()}"
      msg.send "#{msg.match[1]} is definitely away"
    else
      msg.send "I don't know for sure, but I think so"


  robot.hear new RegExp("(#{away_triggers.join('|')})", "i"), (msg) ->
    robot.brain.set "away:#{msg.message.user.name.toLowerCase()}", true
    msg.send 'you are away'
