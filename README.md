# monero-full-node

docker image to run a monero full network node

## How To Use
```
docker run -td \
-v /var/data/blockchain-xmr:/root/.bitmonero \
-p 18080:18080 \
-p 18081:18081 \
--name=monerod \
r4p70r90/monero-full-node
```

## Updates
Manual way:
```
docker stop monerod
docker rm monerod
docker pull r4p70r90/monero-full-node
```
Then launch using the "how to use" command above
    
Automatic way: [v2tec/watchtower](https://github.com/v2tec/watchtower)
