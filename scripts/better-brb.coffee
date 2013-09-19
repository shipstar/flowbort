# Description:
#   Natural availability tracking, but better.
#
# Dependencies:
#   "underscore": ">=1.0.0"
#
# Configuration:
#   None
#
# Commands:
#   brb (or afk, or bbl)
#   hubot is <user> really here?
#   hubot is <user> really away?
#
# Author:
#   tonydewan
#   based on brb by jmhobbs

_ = require('underscore')

module.exports = (robot) ->

  away_triggers = ['brb', 'afk', 'bbl']

  robot.hear /./i, (msg) ->
    message_user = robot.brain.usersForFuzzyName(msg.message.user.name)[0]
    return if message_user.name == robot.name
    if robot.brain.get("away:#{message_user.name}") and !_.contains(away_triggers, msg.message.text)
      msg.send "Welcome back " + msg.message.user.name + "!" if msg.message.match(/back/)
      robot.brain.remove "away:#{message_user.name}"
    else
      _.each robot.brain.users(), (user) ->
        # only if the message starts with the name
        # so hubot doesn't tell you they aren't there every time you mention someone
        if robot.brain.get("away:#{user.name}") and msg.message.text.match new RegExp("^@?#{user.name}", 'i')
          msg.send user.name + " is currently away."

  robot.respond /is @?(\w*)\s?(?:actually|definitely|really|rly)? (?:t?here|away)/i, (msg) ->

    user = robot.brain.usersForFuzzyName(msg.match[1])[0]
    if robot.brain.get "away:#{user.name}"
      msg.send "#{msg.match[1]} is definitely away."
    else
      msg.send "I don't know for sure, but I think #{msg.match[1]} is here."


  robot.hear new RegExp("^(#{away_triggers.join('|')})$", "i"), (msg) ->
    user = robot.brain.usersForFuzzyName(msg.message.user.name)[0]
    robot.brain.set "away:#{user.name}", true
    msg.send "Later, #{msg.message.user.name}."
