# Description:
#   Star wars memes
#
# Dependencies:
#   None
#
#  Configuration:
#   None
#
#  Commands:
#   Nooo - Vader / Kylo are mad
#   A trap - Admiral Ackbar
#
#  Author:
#   jfrankel

nooo = [
  'http://www.nerdist.com/wp-content/uploads/2014/09/Vader-noooo.gif',
  'http://www.nooooooooooooooo.com/vader.jpg',
  'http://i.imgur.com/fE18keE.gif'
]

its_a_trap = [
  'http://i.imgur.com/LaJ9Kmo.gif',
  'http://i.imgur.com/caS91VV.jpg'
]

module.exports = (robot) ->
  robot.hear /no{3,}/i, (msg) ->
    msg.send msg.random nooo

  robot.hear /a\strap/i, (msg) ->
    msg.send msg.random its_a_trap
