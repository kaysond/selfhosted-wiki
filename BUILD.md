# Building selfhosted-wiki
In order to run jekyll, you will need a modern version of Ruby, RubyGems, and the jekyll and bundler gems. For a detailed guide on installing jekyll and its dependencies, see https://jekyllrb.com/docs/installation/

## Installing wiki dependencies
Run `bundle install` to install the required dependencies

## Building the wiki
Run `jekyll build --lsi`. The output will be placed in the `_site/` directory. If you've added a new tag, you'll need to run `scripts/generate_tag_pages.sh` first.