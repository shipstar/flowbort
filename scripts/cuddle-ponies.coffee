# Description:
#   Show Cuddle Ponies every time soccer is mentioned.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   shipstar

images = [
  "http://derpicdn.net/media/W1siZiIsIjIwMTMvMDEvMjIvMTZfMzRfNDJfNjIxXzIyMDc2Ml9fVU5PUFRfX3NhZmVfYW5pbWF0ZWRfcGx1c2hpZV9icm9ueV9jdWRkbGluZ181MGZiZDIzNzdmMTIzYjc0YzAwMDA1MDZfNTBlMDljYzVhNGM3MmQyNmZlMDAwMWQ3LmdpZi5naWYiXSxbInAiLCJyZXNpemVfZ2lmIiwiMjUweDI1MCJdXQ/220762__safe_fluttershy_animated_plushie_heart_brony_cuddling_50fbd2377f123b74c0000506_50e3f539a4c72d7ee8000715.gif"
]

# These aren't working?
# "http://static3.fjcdn.com/thumbnails/comments/falconxmard+rolled+a+random+comment+4967910+posted+by+vavawoom+at+_5dc9ddee8b78799e7e2386afa8eded48.gif"
# "http://static2.fjcdn.com/thumbnails/comments/All+of+these+replies+have+restored+my+faith+in+humanity+637ba98e0216c9a9aaabb8ca1886e919.gif"

module.exports = (robot) ->
  robot.hear /soccer/i, (msg) ->
    msg.send msg.random images