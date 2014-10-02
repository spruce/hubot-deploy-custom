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
#   deploy <tag to deploy> (to) <target>
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
    branchOrTag = ""
    if msg.match[2] != undefined
      branchOrTag = " " + msg.match[2]
    target = "production"
    if msg.match[3] != undefined
      target = msg.match[3]

    exec __dirname + "/../bin/deploy -c " + __dirname + "/../deploy.conf " + target + branchOrTag, (err, stdout, stderr) ->
      message = stdout
      if not stdout?
        message +=  "\r\n" + "Error: no stdout something went wrong"
      if err
        message +=  "\r\n" + "Error: " + err
        if stderr
          message +=  "\r\n" + "stderr:  " + stderr
      msg.send message



