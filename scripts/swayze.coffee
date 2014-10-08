# Description:
#   "Some days you just need to start off with Swayze" - Brian Foreman
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot we need some swayze - Display a random Patrick Swayze gif
#
# Author:
#   armilam

images = [
  "http://media.giphy.com/media/5k9ntv01OQhMY/giphy.gif",
  "http://media.giphy.com/media/RxQOX0g1Ibk5O/giphy.gif",
  "http://media.giphy.com/media/v22JfwLFi6nNS/giphy.gif",
  "http://media.giphy.com/media/N03DjKoHJVjxe/giphy.gif",
  "http://media.giphy.com/media/VzP9FmGm1qWxq/giphy.gif",
  "http://media.giphy.com/media/69OUouHRzrvcA/giphy.gif"
]

module.exports = (robot) ->
  robot.hear /patrick swayze.*/i, (msg) ->
    msg.send msg.random images
