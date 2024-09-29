# monero-full-node (x64) https://github.com/0x556c79/monero-full-node/actions/workflows/publish-docker-package.yml

docker image to run a monero full network node with .conf file.

## The [config](https://github.com/0x556c79/monero-full-node/blob/master/bitmonero.conf) contains Tor related settings. If you don't use it you have to delete it and if you want to use it you have to change the onion address.

# Usage

`docker run -tid --restart=always -v xmrchain:/home/monero/.bitmonero -p 18080:18080 -p 18089:18089 --name=monerod r4p70r/monero-full-node`

## Updates
Manual way:
```
docker stop monerod
docker rm monerod
docker pull r4p70r/monero-full-node
or
docker pull ghcr.io/0x556c79/monero-full-node:latest
```
Then launch using the "how to use" command above
    
Automatic way: [v2tec/watchtower](https://github.com/v2tec/watchtower)

# Donations

I am supporting this image in my spare time and would be very happy about some donations to keep this going.
You can support me by donating here:

![Donation](https://drive.google.com/uc?export=download&id=1zZ_hz6Sgn7Qy5seu2aiGHu8tdlXEZLMF)
- XMR: `8AdNpBsX9QaJu9s8nVXsTH2ZKMDrt7dCt5BpZTEsGvDbQDvMtvppTPVAJGd91DKu599uTYg6syN16HiJ3CtvFLLm97KxViL`

- BTC: `bc1q0r86af4aaydwq4rgya40r0xw2r77j0xjcxznnr`

- Paypal: <noscript><a href="https://www.paypal.com/donate?hosted_button_id=SVVFPC4LU26LC"><img alt="Donate with PayPal button" src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif"></a></noscript>

- Liberapay: <noscript><a href="https://liberapay.com/0x556c79/donate"><img alt="Donate using Liberapay" src="https://liberapay.com/assets/widgets/donate.svg"></a></noscript>
