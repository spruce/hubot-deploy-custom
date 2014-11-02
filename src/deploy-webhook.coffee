# Description:
#   Handle webhooks of gitlab
#
# Dependencies:
#   "url" : ""
#   "querystring" : ""
#
# Configuration:
#   HUBOT_DEPLOY_CUSTOM_CHANNEL
#
#   Put http://<HUBOT_URL>:<PORT>/deploy as your system hook
#   You can also append "?targets=%23room1,%23room2" to the URL to control the
#   message destination.  Using the "target" parameter to override the
#   GITLAB_CHANNEL configuration value.
#
# Commands:
#   None
#
# URLS:
#   /deploy
#
# Author:
#   spruce
fs = require 'fs'
url = require 'url'
properties = require 'properties'
querystring = require 'querystring'
options = properties.parse fs.readFileSync(__dirname + "/../deploy.conf", { encoding: "utf8" }), {sections: true, comments: ";", separators: "", strict: true}
{spawn, exec}  = require 'child_process'

module.exports = (robot) ->
  gitlabChannel = process.env.HUBOT_DEPLOY_CUSTOM_CHANNEL or "#gitlab"

  robot.router.post "/deploy", (req, res) ->
    query = querystring.parse(url.parse(req.url).query)
    hook = req.body

    user = {}
    user.room = if query.targets then query.targets else gitlabChannel
    user.type = query.type if query.type
    # got new deploy request // find out to which place to deploy via the deploy.conf
    # search options for deployhook name == hook.repository.name
    for key, value of options when value.deployhook is hook.repository.name
      # execute real sh script
      exec __dirname + "/../bin/deploy -c " + __dirname + "/../deploy.conf " + key, (err, stdout, stderr) ->
        message = "Deployed #{key} from webhook. (#{value.deployhook})\r\n" + stdout
        if not stdout?
          message +=  "\r\n" + "Error: no stdout something went wrong"
        if err
          message +=  "\r\n" + "Error: " + err
          if stderr
            message +=  "\r\n" + "stderr:  " + stderr
        # write into chat that repo got deployed by webhook
        robot.send user, message
    res.end ""