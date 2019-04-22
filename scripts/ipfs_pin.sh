#!/usr/bin/env bash
set -e
SHWHASH=QmaitnsR9myMoiJBjqRPY6LuHohTcDnLBDvGWdHZpgfNsj
IPADDR=$(dig +short selfhosted.wiki)
echo "Connectecting to selfhosted.wiki ipfs peer"
ipfs swarm connect /ip4/"$IPADDR"/tcp/4001/ipfs/$SHWHASH
echo "Removing all old pins"
ipfs pin ls --type recursive | cut -d' ' -f1 | xargs -n1 ipfs pin rm && ipfs repo gc
echo "Pinning /ipns/selfhosted.wiki"
ipfs pin add /ipns/selfhosted.wiki