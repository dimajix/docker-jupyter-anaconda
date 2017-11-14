FROM dimajix/miniconda:4.3.30
MAINTAINER k.kupferschmidt@dimajix.de

RUN conda install --yes -c conda-forge python=3.6 anaconda jupyterhub jupyterlab notebook

# copy configs and binaries
COPY bin/ /opt/docker/bin/
COPY libexec/ /opt/docker/libexec/

RUN useradd -m jupyter 

ENTRYPOINT ["/opt/docker/bin/entrypoint.sh"]
CMD ["notebook"]
