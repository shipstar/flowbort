# Description:
#   Instrumental Graphs
#
#   Set the environment variable HUBOT_INSTRUMENTAL_GRAPH_EMBED_TOKENS
#   to a comma separated list of room names and embed tokens
#
# Dependencies:
#   moment.js
#
# Configuration:
#   HUBOT_INSTRUMENTAL_GRAPH_EMBED_TOKENS
#
# Commands:
#   graph ((expression), expression) (at time)
#
# Author:
#   eb

sugar = require('sugar')

module.exports = (robot) ->

  room_mappings = {}

  if process.env.HUBOT_INSTRUMENTAL_GRAPH_EMBED_TOKENS?
    mappings = String(process.env.HUBOT_INSTRUMENTAL_GRAPH_EMBED_TOKENS).split(/\s*,\s*/)
    for i in [0..mappings.length]
      room_mappings[mappings[i]] = mappings[i+1]
  else
    robot.logger.warning 'The HUBOT_INSTRUMENTAL_GRAPH_EMBED_TOKENS environment variable not set'

  robot.hear /graph me (([^,\s]+)(,\s*[^,\s]+)*)(\s+(at|for) .+)?/i, (msg) ->
    expressions = msg.match[1]
    clauses     = { "at": -1, "for": 1800 }
    qual_str    = String(msg.match[4]).trim().split(/\s+/)
    state       = null
    stack       = []
    handle      = (parser_state, parser_stack, parser_clauses) ->
                    switch String(parser_state).toLowerCase()
                      when "at"
                        parser_clauses["at"] = Date.create(parser_stack.join(" "))
                      when "for"
                        [distance, unit] = parser_stack
                        mult             = if unit.match(/minutes?/i)
                                             60
                                           else if unit.match(/hours?/i)
                                             3600
                                           else if unit.match(/days?/i)
                                             86400
                                           else if unit.match(/weeks?/i)
                                             604800
                                           else if unit.match(/months?/i)
                                             2592000
                                           else if unit.match(/years?/i)
                                             31536000
                        parser_clauses["for"] = mult * Number(distance)

    for token in qual_str
      if clauses[token]?
        handle(state, stack, clauses)
        stack = []
        state = token
      else
        stack.push(token)
    handle(state, stack, clauses)
    [time, duration] = [clauses["at"], clauses["for"]]
    if time == -1
      time = new Date(new Date().getTime() - duration * 1000)
    embed_token = room_mappings[msg.room]
    if embed_token?
      query = "?"
      for expr in expressions.split(/\s*,\s*/)
        query += escape("graph[metrics][]") + "=" + escape(expr) + "&"
      query += "duration=" + duration + "&start=" + Math.ceil(time.getTime() / 1000)
      embed_url = "https://instrumentalapp.com/graphs/#{embed_token}/new.png" + query
      msg.send(embed_url)
