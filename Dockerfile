FROM prom/node-exporter:v1.3.1

USER nobody

# Dokku will pick this up
EXPOSE 9100

CMD [ "--collector.textfile.directory=/data", \
      "--path.procfs=/host/proc", \
      "--path.sysfs=/host/sys" ]
