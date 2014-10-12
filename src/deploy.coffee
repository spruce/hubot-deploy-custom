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
#   deploy <target> <ref>
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


  robot.respond /deploy(?:\s?(\S+)\s?(\S+)?)?/i, (msg) ->
    # match[0]: everything,              match[1]: target or empty
    # match[2]: ref or empty

    target = "stage"
    if msg.match[1] != undefined
      target = msg.match[1]

    ref = ""
    if msg.match[2] != undefined
      ref = " " + msg.match[2]


    exec __dirname + "/../bin/deploy -c " + __dirname + "/../deploy.conf " + target + ref, (err, stdout, stderr) ->
      message = stdout
      if not stdout?
        message +=  "\r\n" + "Error: no stdout something went wrong"
      if err
        message +=  "\r\n" + "Error: " + err
        if stderr
          message +=  "\r\n" + "stderr:  " + stderr
      msg.send message