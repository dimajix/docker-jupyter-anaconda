#!/bin/bash
set -eo pipefail

# Setup environment
source /opt/docker/libexec/jupyter-init.sh


start_notebook() {
    mkdir -p /mnt/notebooks
    sudo -u jupyter $ANACONDA_HOME/bin/jupyter notebook --ip 0.0.0.0 --port $JUPYTER_PORT --notebook-dir /mnt/notebooks --no-browser
}


start_singleuser() {
    mkdir -p ${JUPYTER_NOTEBOOK_DIR}/${JUPYTERHUB_USER}
    chown -R jupyter ${JUPYTER_NOTEBOOK_DIR}
    sudo -E -u jupyter env PATH=$PATH HOME=$(echo ~jupyter) $@
}


case "$1" in
    "notebook")
        start_notebook
        ;;
    "jupyterhub-singleuser")
        start_singleuser $@
        ;;
    *)
        exec $@
        ;;
esac
exit $?

