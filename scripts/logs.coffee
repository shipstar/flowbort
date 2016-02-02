# Description:
#   Responds to "logs"
#
# Configuration:
#   HUBOT_PAPERTRAIL_API_KEY
#
# Commands:
#   logs search #{papertrail api compatible query}
#   logs company #{company subdomain}
#
# Author:
# Jacob Smith (github.com/jacobsmith)

https = require('https')
api_key = process.env.HUBOT_PAPERTRAIL_API_KEY

query_and_respond = (query, msg) ->
    options = {
      host: "papertrailapp.com",
      path: "/api/v1/events/search.json?q='#{encodeURIComponent(query)}'",
      headers: { "X-Papertrail-Token": api_key }
    }

    callback = (response) ->
      str = ""
      response.on("data", (chunk) ->
        str += chunk
      )

      response.on('end', () ->
        response = JSON.parse(str)
        events = response["events"]
        if events.length == 0
          msg.send "No results found. Please update your query and try again."
          return;

        pretty_json = ''
        for event in events
          pretty_json += JSON.stringify(event)
          pretty_json += "\n"

        if pretty_json.length > 8090 # max length of flowdock message (8096) - 6 backticks for code block
          pretty_json = pretty_json.substring(pretty_json.length - 8090)

        msg.send "```#{pretty_json}```" # wrap it in backticks so it will come back as a code block
      )

    req = https.request(options, callback)
    req.end()


module.exports = (robot) ->
  robot.respond /logs search (.*)/i, (msg) ->
    query = msg.match[1]
    query_and_respond(query, msg)

  robot.respond /logs company (.*)/i, (msg) ->
    subdomain = msg.match[1]
    query_and_respond("host=#{subdomain}", msg)

  robot.respond /logs help/i, (msg) ->
    msg.send '\n' +
      'Put together a query in the form of:   `bob OR ("some phrase" AND sally)`\n' +
      'Each of these should follow `@bort logs search #{query}`\n' +
      'Any way you can query through the Papertrail search should work here as well.\n' +
      '\n' +
      'Examples:\n' +
      '\n' +
      'Our subdomains can be queried with     `host=subdomain` \n' +
      'Statuses can be queried with           `status=500`\n' +
      'API queries can be queried with        `host=api.lesson.ly`\n' +
      'PumaWorkerRestarts can be queried with `PumaWorkerKiller: Out of memory`\n' +
      'AppTimeout errors can be queried with  `code=H12`'
