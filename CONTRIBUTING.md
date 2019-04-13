# Contributing
Pull requests are always welcome both for content and wiki improvements.

## Adding a wiki page
The r/selfhosted wiki is built using [jekyll](https://jekyllrb.com/). Most pages can be added with just markdown syntax. Please see the [examples](https://github.com/kaysond/selfhosted-wiki/tree/master/examples) for more details.

Posts should be placed in the `_posts` directory of either `guides`, `pages`, or `knowledgebase` depending on the type of page (see below). Additional assets should be placed in the proper `assets` directory per the examples.

### Post types
* Guide - installation guides, tutorials, anything too long for a simple page, etc.
* Page - flat pages covering a topic useful to self-hosters (e.g. containers vs native, nextcloud, Linux distro comparison)
* Knowledge Base - problems/errors encountered while using/deploying/upgrading self-hosting apps and their solutions

## Building
See [BUILD.md](https://github.com/kaysond/selfhosted-wiki/tree/master/BUILD.md). Please test build your changes before submitting a pull request. Remember to update the tag pages if necessary (see the Example Guide for details)
