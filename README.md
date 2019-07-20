# Docker bitcoin

Dockerfile of the public image [vulpemventures/lnd:latest]()

Based on the Dockerfile in the `lnd` repo: [https://github.com/lightningnetwork/lnd/blob/master/docker/lnd/Dockerfile](https://github.com/lightningnetwork/lnd/blob/master/docker/lnd/Dockerfile)

Pull the image:

```bash
$ docker pull vulpemventures/lnd
```

Run the container:

```bash
$ docker run -p 9735:9735 -p 10009:10009 -d vulpemventures/lnd <lnd options>
```