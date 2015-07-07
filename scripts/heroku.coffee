# Description:
#   Allows us to do some Heroku things
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   restart {environment}
#
# Author:
#   armilam

# environments =
#   beta: "lessonly-testing"

# module.exports = (robot) ->
#   robot.hear /restart (.+)/i, (msg) ->
#     restart_app = environments[msg.match[1]]
#     if restart_app
#       msg.send environments[msg.match[1]]
#     else
#       msg.send "I don't know how to restart #{msg.match[1]}"

Heroku = require('heroku-client')
heroku = new Heroku(token: process.env.HUBOT_HEROKU_API_KEY)

enviroments =
  beta:
    app: "lessonly-testing"

module.exports = (robot) ->
  auth = (msg, environment, command) ->
    role = "heroku-#{command}-#{environment}"
    hasRole = robot.auth.hasRole(msg.envelope.user, role)
    isAdmin = robot.auth.hasRole(msg.envelope.user, 'admin')
    if not (hasRole or isAdmin)
      msg.reply "Access denied. You must have this role to use this command: #{role}"
      return false
    return true

  respondToUser = (robotMessage, error, successMessage) ->
    if error
      robotMessage.reply "Shucks. An error occurred. #{error.statusCode} - #{error.body.message}"
    else
      robotMessage.reply successMessage

  rpad = (string, width, padding = ' ') ->
    if (width <= string.length) then string else rpad(width, string + padding, padding)

  objectToMessage = (object) ->
    output = []
    maxLength = 0
    keys = Object.keys(object)
    keys.forEach (key) ->
      maxLength = key.length if key.length > maxLength

    keys.forEach (key) ->
      output.push "#{rpad(key, maxLength)} : #{object[key]}"

    output.join("\n")

  info_mapper = (response) ->
    name:         response.name
    url:          response.web_url
    last_release: response.released_at
    maintenance:  response.maintenance
    slug_size:    response.slug_size && "~ #{Math.round(response.slug_size / 1000000)} MB"
    repo_size:    response.repo_size && "~ #{Math.round(response.repo_size / 1000000)} MB"
    region:       response.region && response.region.name
    git_url:      response.git_url
    buildpack:    response.buildpack_provided_description
    stack:        response.build_stack && response.build_stack.name

  # App Info
  robot.respond /heroku info (.*)/i, (msg) ->
    appName = msg.match[1]

    return unless auth(msg, appName, "info")

    msg.reply "Getting information about #{appName}"

    heroku.apps(appName).info (error, info) ->
      respondToUser(msg, error, "\n" + objectToMessage(info_mapper(info)))