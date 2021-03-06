#!/usr/bin/env bash
set -e
source cluster-sync/ephemeral_provider.sh

num_nodes=${KUBEVIRT_NUM_NODES:-1}
mem_size=${KUBEVIRT_MEMORY_SIZE:-5120M}

re='^-?[0-9]+$'
if ! [[ $num_nodes =~ $re ]] || [[ $num_nodes -lt 1 ]] ; then
    num_nodes=1
fi

    #Set the default storage class.
    _kubectl patch storageclass local -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
    _kubectl patch storageclass csi-rbd -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

