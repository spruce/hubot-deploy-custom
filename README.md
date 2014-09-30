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

