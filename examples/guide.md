---
title: "Example Guide"
layout: post
tags:
author:
assets: "/guides/assets/example-guide/"
---
Guide summary. The first paragraph of the guide is used as an excerpt shown in the "Related" section and also in search results. Notice the lack of a title in the guide page. It is generated automatically from the `title` variable above, so there is no need to include it. Feel free to include yourself as the `author`. (NB: if viewing this file on Github, view the `raw` file to see the Front Matter template)

## Filename
The filename MUST start with a properly-formatted date code: `YYYY-MM-DD-`. This date is shown on the page as it's 'Last Updated' date, so it should be updated any time a page is updated. The remainder of the filename should be the page title, lowercase, with non-alphanueric characters removed, and spaces replaced by hyphens (e.g. `example-page-title`)

## Tags
Tags can be added in the Front Matter above with the following syntax: `[tag1, tag2, tag3]`. Tags should be lower case alphanumeric. Please search the existing tags (see `/tags`) before adding your own. If you do add a new tag, you need to run `scripts/generate-tag-pages.sh` from the repository root to regenerate the tag listings.

## Assets
If a page requires additional assets, such as images, scripts, pdf files, etc, those should be stored in a subdirectory of the proper `assets/` folder. The subdirectory should be the same as the page's filename, without the date code. For convenience, define an `assets` variable in the Front Matter above containing the path to that subdirectory. Use liquid syntax as below to generate the path to your assets. Always the `relative_url` filter for all paths.

Example image asset:
`![alt_text]({{ "image.png" | prepend: page.assets | relative_url }})`
