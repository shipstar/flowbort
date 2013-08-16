desc('Ping bort. Are you awake, bort?');
task('ping', function (params) {
  var http = require("http");
  http.request({ host: process.env.PING_URL }, function(response){
    response.on('end', function () {
      console.log('bort: I am awake!');
    });
  }).end();
});