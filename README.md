hubot-deploy-custom
===================

Hubot Script for providing deploy ability with custom scripts

Adds a new command to hubot:
Currently only supporting deploying to one target (prod)
```(name of hubot) deploy <target> <ref to deploy>```
```(name of hubot) deploy <target>``` makes the default action defined in deploy.conf
```(name of hubot) deploy``` defaults to ```(name of hubot) deploy stage```


Upgrading
======

Save your deploy.conf somewhere outside the node_modules folder

Config
======

renaming deploy.conf.example -> deploy.conf 

Added a new filed to the config where you can put the repo name from gitlab so it knows which config to use to deploy on commit
```deployhook web-repo-name``` web-repo-name should be the name of the repositoriy add hubot.url.com/deploy as a push hook on your repo

HUBOT_DEPLOY_CUSTOM_CHANNEL put this into your environment so hubot knows where to post things to


Workflow for working with this addon
====================================

1. commit all things
2. (test it)
3. Increase Version and commit a new tag
4. push to server ```git push origin```
5. chat with hubot ```hubot deploy <target>```


Upgrading
====================================

Save your deploy.conf to another location than node_modules

##Upgrading to 0.1 or after:
Add ```HUBOT_DEPLOY_CUSTOM_CHANNEL``` to your environment



Work based on following people
==============================


Uses nice deploy script from visionmedia
https://github.com/visionmedia/deploy

Matt Pegler for the inspiration
http://www.pegler.co/2012/03/django-deployment.html



## Directory Structure

Using the common directory structure for hubot script packages it will be easy
to manage and allow others to easily contribute to your package.

### script

This directory is home to a couple of development scripts; `bootstrap` and `test`
they're used to bootstrap the development environment and run tests
respectively.

### src

This directory is home to the actual hubot scripts in the package. Your
`index.coffee` entry point will load the scripts from this directory.

### test

This directory is home to any tests you write for your scripts. This example
package uses Mocha, Chai and Sinon to manage writing tests.

## Advantages of Building a Package

Some of the advantages of building an npm package for your hubot script(s) are:

* You don't need to rely on when hubot-scripts package is released.
* You can specify dependencies in the `package.json` rather than have users
  manually specify them
* You can easily add tests using your favourite frameworks and libraries

