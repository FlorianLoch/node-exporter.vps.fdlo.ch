# node-exporter in Dokku

This repository contains the configuration of the node-exporter instance running at vps.fdlo.ch.

Following the instructions in https://richardwillis.info/blog/monitor-dokku-server-prometheus-loki-grafana.

Add a git remote for Dokku:
```bash
git remote add dokku dokku@vps.fdlo.ch:node-exporter
```

Additionally, some setup with Dokku is necessary:

```bash
dokku apps:create node-exporter

dokku storage:mount node-exporter /proc:/host/proc:ro
dokku storage:mount node-exporter /:/rootfs:ro
dokku storage:mount node-exporter /sys:/host/sys:ro
dokku storage:mount node-exporter /apps/node-exporter:/data

cd /apps && mkdir ./node-exporter && sudo chown nobody:nogroup node-exporter

dokku http-auth:on node-exporter <username> <password>

dokku network:set node-exporter attach-post-deploy prometheus-bridge

dokku checks:disable node-exporter

# Apps needs to be deployed once before calling this
dokku proxy:ports-set node-exporter http:80:9100
dokku domains:remove node-exporter node-exporter.fdlo.ch
dokku domains:add node-exporter node-exporter.vps.fdlo.ch

dokku letsencrypt:enable node-exporter
```
