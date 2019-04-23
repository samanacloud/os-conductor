ETCD=http://10.255.254.200:2379

e() {
    etcdctl -C ${ETCD} "$@"
}