# Stage 1: Build the rootfs
# Use the RHEL toolbox images which has the certs needed
# See also: https://github.com/containers/toolbox/issues/1661
FROM quay.io/rhel-devel-tools/rhel-developer-toolbox:latest AS builder
LABEL author="Micah Abbott <miabbott@redhat.com>"
COPY . /pet
RUN cd /pet && \
    ./build && \
    rm -rf /pet /var/cache/dnf && \
    rm -rf /etc/yum.repos.d/{azure-cli,fedora-modular,fedora-updates-modular,fedora-updates-testing-modular,google-cloud-sdk,hashicorp,vscode}.repo

# Stage 2: Split the rootfs into content-based layers via chunkah
# https://github.com/coreos/chunkah
ARG CHUNKAH_CONFIG_STR
FROM quay.io/coreos/chunkah:latest AS chunkah
ARG CHUNKAH_CONFIG_STR
RUN --mount=from=builder,src=/,target=/chunkah,ro \
    --mount=type=bind,target=/run/src,rw \
        chunkah build > /run/src/out.ociarchive

# Stage 3: Final image from the split archive
FROM oci-archive:out.ociarchive
CMD ["/bin/bash"]
