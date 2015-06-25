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
#   stick! (For this reason I am deploying)
#   !stick
#   hubot who has the stick?
#   hubot make <user> drop the stick!
#
# Author:
#   tonydewan

_ = require('underscore')

module.exports = (robot) ->

  room_or_flow = (msg) ->
    ( msg.message.user.flow || msg.message.room || "" )

  key = (msg) ->
    "#{room_or_flow(msg)}:stick"

  give_me_the_stick = (msg) ->
    stick = robot.brain.get key(msg)
    desc = msg.match[1]
    message_user = robot.brain.userForId msg.message.user.id

    if stick
      stick_user = robot.brain.userForId stick

      if stick_user == message_user && desc
        robot.brain.set "#{key(msg)}:desc", desc
        msg.send "okay #{message_user.name}, stick still yours!"
      else
        msg.send "I can't give the stick to you, #{message_user.name}. #{stick_user.name} has the stick."

    else
      robot.brain.set key(msg), message_user.id
      if desc
        robot.brain.set "#{key(msg)}:desc", desc
      msg.send "okay #{message_user.name}, you have the stick!"

  who_has_the_stick = (msg) ->
    stick = robot.brain.get key(msg)
    desc  = robot.brain.get "#{key(msg)}:desc"
    if stick
      stick_user = robot.brain.userForId stick
      msg.send "#{stick_user.name} has the stick."
      if desc
        msg.send "Here's why: #{desc}"
    else
      msg.send "No one has the stick."

  take_the_stick = (msg)->
    stick = robot.brain.get key(msg)
    if stick
      stick_user = robot.brain.userForId stick
      robot.brain.set key(msg), null
      robot.brain.set "#{key(msg)}:desc", null
      msg.send "Stick released from #{stick_user.name}'s grasp."
    else
      msg.send "No one has the stick."



  robot.respond /give me the stick\! ?(.*)?/i, give_me_the_stick
  robot.hear /^stick\! ?(.*)?/i, give_me_the_stick

  robot.respond /who has stick\?/i, who_has_the_stick
  robot.hear /^stick\?/i, who_has_the_stick

  robot.hear /make @?(\w*) drop the stick/i, take_the_stick
  robot.hear /^\!stick/i, take_the_stick
