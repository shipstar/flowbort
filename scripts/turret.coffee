# Description:
#   Interact with Hubot's turrets
#
# Commands:
#   hubot turret - See what Hubot's turrets are thinking.
#
# Notes:
#   I don't hate you.

util = require 'util'
cheerio = require 'cheerio'

module.exports = (robot) ->

  robot.respond /turret/i, (msg) ->
    robot.http("http://theportalwiki.com/wiki/Turret_voice_lines")
      .get() (err, res, body) ->
        $ = cheerio.load(body)

        wavs = $("a[href$=wav]")
        index = Math.floor(Math.random() * wavs.length)
        msg.send $(wavs[index]).attr('href')