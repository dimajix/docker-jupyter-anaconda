#!/bin/bash
set -eo pipefail

# Setup environment
source /opt/docker/libexec/jupyter-init.sh


start_notebook() {
    mkdir -p ${JUPYTER_NOTEBOOK_DIR}
    chown -R jupyter ${JUPYTER_NOTEBOOK_DIR}
    sudo -E -u jupyter env PATH=$PATH HOME=${JUPYTER_NOTEBOOK_DIR} jupyter notebook --ip 0.0.0.0 --port $JUPYTER_PORT --notebook-dir ${JUPYTER_NOTEBOOK_DIR} --no-browser
}


start_as_jupyter() {
    chown -R jupyter ${JUPYTER_NOTEBOOK_DIR}
    sudo -E -u jupyter env PATH=$PATH HOME=${JUPYTER_NOTEBOOK_DIR} $@
}



case "$1" in
    "notebook")
        start_notebook
        ;;
    "jupyterhub-singleuser")
        start_as_jupyter $@
        ;;
    "jupyter-labhub")
        start_as_jupyter $@
        ;;
    *)
        exec $@
        ;;
esac
exit $?

