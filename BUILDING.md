
# Building selfhosted-wiki

## Jekyll
In order to run jekyll, you will need a modern version of Ruby, RubyGems, and the jekyll and bundler gems. For a detailed guide on installing jekyll and its dependencies, see https://jekyllrb.com/docs/installation/

### Installing wiki dependencies
Run `bundle install` inside the repo to install the required dependencies

### Building the wiki
Run `jekyll build --lsi`. The output will be placed in the `_site/` directory. If you've added a new tag, you'll need to run `scripts/generate_tag_pages.sh` first.


## Github Pages
If you don't want to use Jekyll to build the wiki, you can also use [Github Pages](https://pages.github.com/). Simply fork the repo and enable Pages in the settings of your fork. You can even edit or create pages from within Github!