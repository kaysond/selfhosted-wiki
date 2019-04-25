#!/usr/bin/env bash
# This is the script used to push wiki updates to IPFS and update the DNS entry
# It is activated by a github webhook
set -euo pipefail
logger -t "update-selfhosted-wiki" -p user.info -i "Updating selfhosted.wiki"
export PATH="$PATH:/root/gems/bin"
export GEM_HOME=/root/gems
cd /usr/src/selfhosted-wiki
git pull
/root/gems/bin/jekyll build --lsi --baseurl=/ipns/selfhosted.wiki/
export IPFS_PATH=/var/lib/ipfs
HASH=$(ipfs add -Q -r _site)
PROVIDER="namecheap"
DOMAIN="selfhosted.wiki"
export LEXICON_NAMECHEAP_USERNAME=""
export LEXICON_NAMECHEAP_TOKEN=""
lexicon $PROVIDER delete $DOMAIN TXT --name=@
lexicon $PROVIDER --ttl 300 create $DOMAIN TXT --name=@ --content="dnslink=/ipfs/$HASH"