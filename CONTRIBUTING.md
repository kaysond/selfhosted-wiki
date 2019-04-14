# Contributing
Pull requests are always welcome both for content and wiki improvements.

## Adding a wiki page
Adding a wiki page is as simple as creating a markdown file in the proper directory: the `_posts` directory of either `guides`, `pages`, or `knowledgebase` depending on the type of page. The IPFS instance of the r/selfhosted wiki is built using [jekyll](https://jekyllrb.com/), but note that you can contribute to the wiki entirely through Github by using its built-in editor and Github Pages (see [#Building](Building)).

### Page types
* Guide - installation guides, tutorials, anything too long for a simple page, etc.
* Page - flat pages covering a topic useful to self-hosters (e.g. containers vs native, nextcloud, Linux distro comparison)
* Knowledge Base - problems/errors encountered while using/deploying/upgrading self-hosting apps and their solutions

### Page format

#### File Name
The filename MUST start with a properly-formatted date code: `YYYY-MM-DD-`. This date is shown on the page as it's 'Last Updated' date, so it should be updated any time a page is updated. The remainder of the filename should be the page title, lowercase, with non-alphanueric characters removed, and spaces replaced by hyphens. (e.g. `2019-04-12-example-guide.md`)

#### Front Matter
Pages must start with jekyll's "Front Matter":
```
---
title:
layout: post
tags:
author:
assets:
---
```
`layout` must be `post`, but the rest of the fields are author-defined. `title` is the only required field, but authors are encouraged to complete all of them:
* `title` - The title is automatically listed at the top of your page (so no need to include it in your content). It is also used in the wiki page listings
* `tags` - The syntax for tags is `[tag1, tag2, tag3]`. Tags should be lower case alphanumeric. Please search the existing tags (see `/tags`) before adding your own. If you do add a new tag, you need to run `scripts/generate-tag-pages.sh` from the repository root to regenerate the tag listings.
* `author` - The author's name, which is listed at the bottom of the page
* `assets` - A convenience variable for the directory containing your pages assets (see below)

#### Excerpt
The first paragraph of content in a page is used as an excerpt shown in the "Related" section and also in search results. For this reason the first content on a page should be paragraph text (i.e. not a heading) and summarize the page. Since the page title is automatically added by jekyll, it should not be explicitly added to the page's source markdown.

#### Assets
If a page requires additional assets, such as images, scripts, pdf files, etc, those should be stored in a subdirectory of the `assets` directory adjacent to the `_posts` directory in which the page resides. The subdirectory should be the same as the page's filename, without the date code or extension. For example, if the page is `guides/_posts/2019-04-12-example-guide-title.md` then the assets should be placed in `/guides/assets/example-guide-title/`. For convenience, define an `assets` variable in the Front Matter above containing the path to that subdirectory. Use the following [Liquid](https://jekyllrb.com/docs/liquid/) syntax to point to your assets: `{{ "image.png" | prepend: page.assets | relative_url }}`).

#### Syntax and Formatting
Most pages should be written entirely in [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet). Although jekyll does support various variables via Liquid, use is strongly discouraged for the sake of compatibility. The exceptions are: asset paths, links, and syntax highlighting. For those, Liquid must be used. Additionally, always use `| relative_url` for paths. See [the jekyll documentation](https://jekyllrb.com/docs/liquid/tags/) for details. Guides and pages are relatively free form. For knowledge base entries, however, please follow the formatting in the example.

## Building
See [BUILDING.md](/BUILDING.md). Please test build your changes before submitting a pull request.

## Examples
* [guide](/examples/2019-04-12-example-guide.md)
* [page](/examples/2019-04-12-example-page.md)
* [knowledgebase](/examples/2019-04-12-example-kb.md)
