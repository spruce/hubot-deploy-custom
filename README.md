hubot-deploy-custom
===================

Hubot Script for providing deploy ability with custom scripts

Adds a new command to hubot:
```(name of hubot) deploy tag <tag to deploy>```
```(name of hubot) deploy <branch>```

Config
======

Set the ENV Vars:

HUBOT_DEPLOY_CUSTOM_DIR


Workflow for working with this addon
====================================

1. commit all things
2. (test it)
3. Increase Version and commit a new tag with ```npm version patch```
4. push to server ```git push origin [tagname]```
5. chat with hubot ```hubot deploy <num>```

