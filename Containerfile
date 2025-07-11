# Use the RHEL toolbox images which has the certs needed
# See also: https://github.com/containers/toolbox/issues/1661
FROM  quay.io/rhel-devel-tools/rhel-developer-toolbox:latest
LABEL author="Micah Abbott <miabbott@redhat.com>"
COPY . /pet
RUN cd /pet && \
    ./build && \
    rm -rf /pet /var/cache/dnf && \
    rm -rf /etc/yum.repos.d/{azure-cli,fedora-modular,fedora-updates-modular,fedora-updates-testing-modular,google-cloud-sdk,hashicorp,vscode}.repo
CMD ["/bin/bash"]
