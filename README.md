# monero-full-node

docker image to run a monero full network node with .conf file for configuration

# Usage

`docker run -tid --restart=always -v xmrchain:/home/monero/.bitmonero -p 18080:18080 -p 18088:18088 -p 18089:18089 --name=monerod r4p70r/monero-full-node`

## Updates
Manual way:
```
docker stop monerod
docker rm monerod
docker pull r4p70r/monero-full-node
```
Then launch using the "how to use" command above
    
Automatic way: [v2tec/watchtower](https://github.com/v2tec/watchtower)

# Donations

I am supporting this image in my spare time and would be very happy about some donations to keep this going.
You can support me by sending some XMR to: `86fbBwa9XfZAHqMBA7TowSGb5oZqnBgUFJ8Zxh2WchjHWKw6Xx8zpwQiA4fFZVjYWAdE2jCes8WMujZEjYUwDomtVKTfvkb`

![Donation](https://docs.google.com/uc?export=download&id=13Z0oUgUKZsC6HCo69BHS5b9mvffT6QRG)
