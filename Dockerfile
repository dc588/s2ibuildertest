FROM jupyter/minimal-notebook:latest
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends libav-tools rsync && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

LABEL io.k8s.description="S2I builder for Jupyter (minimal-notebook)." \
      io.k8s.display-name="Jupyter (minimal-notebook)" \
      io.openshift.expose-services="8888:http" \
      io.openshift.tags="builder,python,jupyter" \
      io.openshift.s2i.scripts-url="image:///opt/app-root/s2i/bin"
COPY s2i /opt/app-root/s2i

USER 1000

CMD [ "/opt/app-root/s2i/bin/run" ]
