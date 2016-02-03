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
    encodedQuery = encodeURIComponent(query)

    options = {
      host: "papertrailapp.com",
      path: "/api/v1/events/search.json?q='#{encodedQuery}'",
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
          message = event.message
          program = event.program
          display_received_at = event.display_received_at

          pretty_json += "#{display_received_at} | #{program} | #{message}"
          pretty_json += "\n"

        last_id = events.slice(-1)[0].id

        # trim the code down to size if need be, but leave room for a link at the end to Papertrail
        if pretty_json.length > 7800 # max length of flowdock message (8096), but we want to leave room for encoded params in the link below
          pretty_json = pretty_json.substring(pretty_json.length - 7800)

        message = "```#{pretty_json}```" # format as a code block
        # add a link to the most recent log entry
        message += "\nhttps://papertrailapp.com/systems/lessons-igo/events?q=#{encodedQuery}&centered_on_id=#{last_id}"

        msg.send message
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
      'http://help.papertrailapp.com/kb/how-it-works/search-syntax/\n' +
      '\n' +
      'Examples:\n' +
      '\n' +
      'Our subdomains can be queried with     `host=subdomain` \n' +
      'Statuses can be queried with           `status=500`\n' +
      'API queries can be queried with        `host=api.lesson.ly`\n' +
      'PumaWorkerRestarts can be queried with `PumaWorkerKiller: Out of memory`\n' +
      'AppTimeout errors can be queried with  `code=H12`'
