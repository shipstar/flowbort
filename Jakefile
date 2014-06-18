desc('Ping bort. Are you awake, bort?');
task('ping', function (params) {
  var http = require("http");
  var postReq = http.request({
    host: process.env.PING_URL,
    port: 80,
    path: '/hubot/ping',
    method: 'POST'
  }, function (res) {
    console.log(res.statusCode);
  });

  postReq.end()
});
