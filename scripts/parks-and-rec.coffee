# Description:
#   Get, g-g-get get get get that paper.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   parks - Display a random Parks and Rec gif/image
#
# Author:
#   shipstar

images = [
  # jean ralphio
  "http://cdn.uproxx.com/wp-content/uploads/2012/11/jeanralphio-dunk.gif",
  "http://cdn.uproxx.com/wp-content/uploads/2012/11/jeanralphio-five.gif",
  "http://cdn.uproxx.com/wp-content/uploads/2012/11/jeanralphio-opening.gif",
  "http://scootsa1000momofthree.files.wordpress.com/2012/11/rent-a-swag.gif?w=655",
  "http://media.tumblr.com/tumblr_llk9neyXnN1qav6pp.gif",

  # leslie
  "http://stream1.gifsoup.com/view3/4045479/leslie-knope-no-o.gif",
  "http://28.media.tumblr.com/tumblr_li9t8aFUB91qa3c5to1_500.gif",
  "http://static.tumblr.com/jqoueft/lntmejhun/leslie-knope.gif",
  "http://31.media.tumblr.com/tumblr_mbei58Ghyx1rip69go1_500.gif",

  # ron
  "http://images5.fanpop.com/image/photos/27100000/Ron-Swanson-Dances-The-Fight-parks-and-recreation-27126517-362-180.gif",
  "http://www.reactiongifs.com/wp-content/uploads/2013/06/giggle.gif",
  "http://assets0.ordienetworks.com/misc/ronswanson-gun.gif",
  "http://24.media.tumblr.com/tumblr_ln1z8jTyso1qkmujbo1_500.gif",

  # chris
  "http://i.imgur.com/bjpc18m.gif",

  # april
  "http://media.tumblr.com/tumblr_mc1txmZtfU1qh6ss0.gif",

  # andy
  "http://cdn.uproxx.com/wp-content/uploads/2013/07/andy-dwyer-dealornodeal.gif",
  "http://tn.loljam.com/14/upload/post/201305/24/10816/5525f562d4db34aafbc91c6f31d20639.gif",
  "http://replygif.net/i/1136.gif",

  # tom
  "http://25.media.tumblr.com/tumblr_lr40gt7FrS1qly9zdo1_400.gif",
  "http://iamthepdxsx.files.wordpress.com/2012/12/tom-haverford-dunzo.gif?w=500",
  "http://3.bp.blogspot.com/-Vn6c6IlAJJU/TcY6j7X6KFI/AAAAAAAAAY4/cTgITFFMsJs/s400/A0X8h.gif",
  "http://static.fjcdn.com/gifs/tom_a19099_2325116.gif",

  # jerry
  "http://i1.ytimg.com/vi/T5nHVRb1AyU/hqdefault.jpg",
  "http://oyster.ignimgs.com/wordpress/stg.ign.com/2013/04/Parks-and-Recreation-Season-5-Two-Jerrys-Retirement.jpg",
  "http://www.simplyinthesuburbs.com/wp-content/uploads/2013/04/Breakfast-Traditions.jpg",
  "http://cdn.uproxx.com/wp-content/uploads/2012/01/jerry-comicsans2.gif"

  # ben
  "http://thoughtcatalog.files.wordpress.com/2012/12/benwyatt-micdrop.gif?w=584",
  "http://31.media.tumblr.com/32f271e2c7da42a7bcdaaa3960ba9634/tumblr_mqvgqay1WH1rdh9azo1_500.gif",
]

module.exports = (robot) ->
  robot.respond /parks/i, (msg) ->
    msg.send msg.random images

  robot.hear /comic sans/i, (msg) ->
    msg.reply "http://cdn.uproxx.com/wp-content/uploads/2012/01/jerry-comicsans2.gif"
