# Description:
#   Who has the stick?
#
# Dependencies:
#   "underscore": ">=1.0.0"
#
# Configuration:
#   None
#
# Commands:
#   stick?
#   stick!
#   !stick
#   hubot who has the stick?
#   hubot make <user> drop the stick!
#
# Author:
#   tonydewan
#   based on brb by jmhobbs

_ = require('underscore')

module.exports = (robot) ->

  give_me_the_stick = (msg) ->
    message_user = robot.brain.usersForFuzzyName(msg.message.user.name)[0]
    if robot.brain.get "#{msg.message.room}:stick"
      stick_user = robot.brain.userForId robot.brain.get("#{msg.message.room}:stick")
      msg.send "I can't give the stick to you, #{message_user.name}. #{stick_user.name} has the stick."
    else
      robot.brain.set "#{msg.message.room}:stick", message_user.id
      msg.send "okay #{message_user.name}, you have the #{msg.message.room} stick!"

  who_has_the_stick = (msg) ->
    if robot.brain.get "#{msg.message.room}:stick"
      stick_user = robot.brain.userForId robot.brain.get("#{msg.message.room}:stick")
      msg.send "#{stick_user.name} has the stick."
    else
      msg.send "No one has the #{msg.message.room} stick."

  take_the_stick = (msg)->
    if robot.brain.get "#{msg.message.room}:stick"
      stick_user = robot.brain.userForId robot.brain.get("stick")
      robot.brain.set "#{msg.message.room}:stick", null
      msg.send "#{stick_user.name} had the #{msg.message.room} stick, but I just took it."
    else
      msg.send "No one has the stick."



  robot.respond /give me the stick\!/i, give_me_the_stick
  robot.hear /^stick\!/i, give_me_the_stick

  robot.respond /who has stick\?/i, who_has_the_stick
  robot.hear /^stick\?/i, who_has_the_stick

  robot.hear /make @?(\w*) drop the stick/i, take_the_stick
  robot.hear /^\!stick/i, take_the_stick
