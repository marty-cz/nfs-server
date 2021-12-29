FROM alpine:3.15.0

RUN apk add --no-cache --update --verbose nfs-utils==2.5.4-r1 bash=5.1.8-r0 iproute2==5.15.0-r2 && \
    rm -rf /var/cache/apk /tmp /sbin/halt /sbin/poweroff /sbin/reboot && \
    mkdir -p /var/lib/nfs/rpc_pipefs /var/lib/nfs/v4recovery && \
    echo "rpc_pipefs    /var/lib/nfs/rpc_pipefs rpc_pipefs      defaults        0       0" >> /etc/fstab && \
    echo "nfsd  /proc/fs/nfsd   nfsd    defaults        0       0" >> /etc/fstab

COPY README.md /
COPY exports /etc/
COPY nfsd.sh /usr/bin/nfsd.sh
RUN chmod +x /usr/bin/nfsd.sh

ENTRYPOINT ["/usr/bin/nfsd.sh"]
