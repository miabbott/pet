# pet

(Shamelessly forked from <https://github.com/jlebon/pet>)

[![quay.io repository](https://img.shields.io/badge/updated-2025--08--31-green)](https://quay.io/repository/miabbott/pet)

This is my [Toolbx](https://containertoolbx.org/) container
that I use everyday for hacking on
[CoreOS](https://github.com/coreos) projects. I reprovision
it every week.

To use:

```bash
toolbox create --image quay.io/miabbott/pet
toolbox enter pet
```

For Red Hat engineers, once connected to the VPN, you'll
want to run `rhsetup` to install certs and `rhpkg`.

This repository runs a weekly
[GitHub Actions job](https://github.com/miabbott/pet/actions/workflows/build.yml)
to update a
[container image](https://quay.io/repository/miabbott/pet)
hosted on [Quay.io](https://quay.io/) (that workflow is
heavily based on the one from
[this repo](https://github.com/coreos/mkpasswd-container)).
