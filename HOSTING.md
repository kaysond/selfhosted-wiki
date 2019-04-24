# Hosting

The wiki is hosted on [IPFS](https://ipfs.io) at `/ipns/selfhosted.wiki/`. When someone attempts to access the wiki via an IPFS gateway, the gateway will search its peer nodes for the content, cache it for future requests, then serve it to the user. This process can be quite slow if not many peers are hosting the content. Public gateways can, and often do,  "garbage collect" content that has not been accessed recently, so the more hosts that have "pinned" the content, the better.

## Installing IPFS

Installing IPFS is as easy as copying a binary to somewhere in your `$PATH`. See https://docs.ipfs.io/introduction/install/ for detailed instructions.

**Note:** Due to a [memory leak issue](https://github.com/ipfs/go-ipfs/issues/3532), it is recommended to build from source for the time being.

## Creating an IPFS node

After installing IPFS, you'll want to create a location for its data and initialize the configuration

```
mkdir -p /var/lib/ipfs
export IPFS_PATH=/var/lib/ipfs
ipfs init --profile server
```

By default, the node only listens on localhost. You'll want to allow other peers to connect by running:
`ipfs config --json Addresses.Swarm '["/ip4/0.0.0.0/tcp/4001", "/ip6/::/tcp/4001"]'`
and don't forget to make sure this port (4001) is publicly accessible!

Finally, run `ipfs daemon --enable-gc` to start the IPFS node

You should then be able to access the wiki by going to `http://localhost:8080/ipns/selfhosted.wiki`. The initial content download may take some time, so try connecting to the primary node directly (see below)

## Pinning and updating selfhosted.wiki

In order to prevent garbage collection (automatic or manual) from removing the wiki content, it should be pinned using `ipfs pin add /ipns/selfhosted.wiki/`. Note that since IPFS is addressed by content, this command must be re-run every time the wiki content is updated, as the IPNS domain name will resolve elsewhere. A sample updating script is provided at scripts/ipfs_pin.sh. The script manually connects to the primary selfhosted.wiki IPFS node (to speed up download time), removes all old pins, and pins the new content. Please consider running this as a cron job!

### ipfsd Service

You'll probably want to run the node as a service. If your system supports `systemd` you can use the [example service file](scripts/ipfsd.service).
Copy it somewhere like `/lib/systemd/system` then run `systemctl enable ipfsd; systemctl start ipfsd`.
