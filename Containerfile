FROM registry.fedoraproject.org/fedora-toolbox:42
LABEL author="Micah Abbott <miabbott@redhat.com>"
COPY . /pet
RUN cd /pet && \
    ./build && \
    rm -rf /pet /var/cache/dnf && \
    rm -rf /etc/yum.repos.d/{azure-cli,fedora-modular,fedora-updates-modular,fedora-updates-testing-modular,google-cloud-sdk,hashicorp,vscode}.repo
CMD ["/bin/bash"]
