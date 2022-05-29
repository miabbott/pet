FROM registry.fedoraproject.org/fedora-toolbox:36
LABEL author="Micah Abbott <miabbott@redhat.com>"
COPY . /pet
RUN cd /pet && ./build && rm -rf /pet /var/cache/dnf
CMD ["/bin/bash"]
