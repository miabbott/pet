# pet

(Shamelessly forked from <https://github.com/jlebon/pet>)

[![quay.io repository](https://img.shields.io/badge/updated-2026--07--21-green)](https://quay.io/repository/miabbott/pet)

This is my [Distrobox](https://distrobox.it/) container
that I use everyday for hacking on
[CoreOS](https://github.com/coreos) projects. I reprovision
it every week.

To use:

```bash
distrobox create --image quay.io/miabbott/pet
distrobox enter pet
```

For Red Hat engineers, once connected to the VPN, you'll
want to run `rhsetup` to install certs and `rhpkg`.

The container image is built using a multi-stage
[Containerfile](Containerfile) that uses
[chunkah](https://github.com/coreos/chunkah) to split the
image into content-based layers, so that pulling updates
only downloads the layers that changed.

This repository runs a weekly
[GitHub Actions job](https://github.com/miabbott/pet/actions/workflows/build.yml)
to update a
[container image](https://quay.io/repository/miabbott/pet)
hosted on [Quay.io](https://quay.io/).
