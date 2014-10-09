# Description:
#   Muahahahahahahaha! Muhahahahahahaha!
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   100 billion dollars!
#
# Author:
#   armilam

dr_evil = [
  "http://keepitnerdy.com/wp-content/uploads/2014/05/tumblr_lgj0nq1TjM1qggekro1_500.gif",
  "http://media.giphy.com/media/nXU1FF5HS2eFG/giphy.gif",
  "http://media.giphy.com/media/APcFiiTrG0x2/giphy.gif",
  "http://media.giphy.com/media/FrajBDPikVqBG/giphy.gif"
]

austin = [
  "http://img.pandawhale.com/85594-austin-powers-HUH-WHAT-gif-WTF-YTPV.gif",
  "http://media.tumblr.com/tumblr_kxz26lDGJ01qzaeks.gif"
]

module.exports = (robot) ->
  robot.hear /(1(00)?|one( hundred)?) (m|b|tr)illion dollars/i, (msg) ->
    msg.send msg.random dr_evil

  robot.hear /ye?ah?,? baby/i, (msg) ->
    msg.send msg.random austin
