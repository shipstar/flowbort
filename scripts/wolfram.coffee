# Description:
#   Allows hubot to answer almost any question by asking Wolfram Alpha
#
# Dependencies:
#   "wolfram": "0.2.2"
#
# Configuration:
#   HUBOT_WOLFRAM_APPID - your AppID
#
# Commands:
#   hubot question <question> - Searches Wolfram Alpha for the answer to the question
#
# Notes:
#   This may not work with node 0.6.x
#
# Author:
#   originally by dhorrigan
#   updated by tonydewan

Wolfram = require('wolfram').createClient(process.env.HUBOT_WOLFRAM_APPID)

module.exports = (robot) ->
  robot.hear /(q(?:uestion)?:) (.*)$/i, (msg) ->
    Wolfram.query msg.match[2], (e, result) ->
      if result and result.length > 0
        msg.send result[1]['subpods'][0]['value']