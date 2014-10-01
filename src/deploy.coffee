# Description:
#   Post gitlab related events using gitlab hooks
#
# Dependencies:
#   "url" : ""
#   "querystring" : ""
#
# Configuration:
#   HUBOT_DEPLOY_CUSTOM_DIR
#
#
# Commands:
#   deploy tag <tag to deploy> (to) <target>
#   deploy <branch> (to) <target>
#   deploy
#
# URLS:
#   None
#
# Author:
#   spruce
#   inspired by http://www.pegler.co/2012/03/django-deployment.html

{spawn, exec}  = require 'child_process'
module.exports = (robot) ->


  robot.respond /deploy(?:( tag)? (\S*)(?: to)?(\s\S*)?)?/i, (msg) ->
    # match[0]: everything,             match[1]: " tag" or empty,
    # match[2]: tag or branch or empty, match[3]: target or empty,
    branchOrTag = "master"
    if msg.match[2] != undefined
      branchOrTag = msg.match[2]
    target = "production"
    if msg.match[3] != undefined
      msg.send "currently only deploying to production"
      #target = msg.match[3]

    # this is custom
    # will be read from .deploy.conf
    exec __dirname + "/bin/deploy -c ../deploy.conf production master", (err, stdout, stderr) ->
      if err
        msg.send "Error: " + err
      if stderr
        msg.send "err:  " + stderr
      if stdout
        msg.send "out:  " + stdout


    if msg.match[1] == " tag"
      # we have a tag
      # TODO check if tag exists
      msg.send "Should deploy from tag msg.match[1] to prod"
    else
      # TODO check if branch exists
      msg.send "Should deploy from tag " + msg.match[1] + " to production"

