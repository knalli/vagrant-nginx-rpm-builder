# Nginx RPM builder with SPDY
Unfortunately, nginx.org does not provide RPMs with SPDY support. However, it can be built on your self with only a minor
change in the SPEC file (see [src/build/diff/nginx.spec.patch](src/build/diff/nginx.spec.patch)) and a separately
downloaded version of OpenSSL.

## Requirements
Generally spoken, the requirement for a RPM build is a binary compatible building environment with additional build
tooling packages.

This build task uses `Vagrant` to configure a virtual machine configured in the [configuration file](Vagrantfile) based
on a CentOS (64bit). For this setup, the command `vagrant` should be available in the path.

## Quick start
Use the shell script `build.sh` in the project root directory.

Internally, the scripts processes the following tasks:

1. create a new virtual machine (based on a predefined one which have to be downloaded at the very first time),
2. boot into it,
3. provisioning all required build tools,
4. downloads source versions of OpenSSL and Nginx,
5. patches the `nginx.spec` enabling SPDY support,
6. building the actual RPM,
7. stores the effective RPM at `target/`,
8. shutdowns the virtual machine again.

Normally, if you start the script a second time, it will reuse the created and provisioned machine (which was only
halted). You can force destroying and recreating the machine with `./build.sh -f`.

## Configuration
You can place a configuration property file at `build.yaml` which will be ignored by git.

This is the default content:

```
dependencies:
  nginx_rpm_stable: true
  nginx_rpm_version: 1.4.2
  nginx_rpm_release: 1
  openssl_version: 1.0.1e
```

* `nginx_rpm_stable`: `true` for the stable, `false` for the mainline repository
* `nginx_rpm_version`: the version (should be available in the selected repository as src rpm)
* `nginx_rpm_release`: the release (*)
* `openssl_version`: the used OpenSSL version

An example for the current baseline:

```
dependencies:
  nginx_rpm_stable: false
  nginx_rpm_version: 1.5.9
  nginx_rpm_release: 1
  openssl_version: 1.0.1e
```

At the moment, changes of this configuration has only an effect on provisioning time which means you have to rebuild the
machine.

## Under the hood
At first, the system will be configured to use additional YUM repositories for Puppet which is used for provisioning.

With Puppet, the following custom puppet modules will be used:

* base: some base stuff
* rpmbuild: several packages used for RPM building incl. make, gcc or rpm-utils
* nginxdevel: mainly it provides a special `build.sh` on the virtual machine which builds the actual RPM

The mentioned `build.sh` on the VM (it's located at `home/vagrant/build.sh` (copied from
[src/puppet/modules/nginxdevel/files/build.sh](here)) creates on the fly a rpm build scrpipt based on the individual
settings of [build.yaml.default](build.yaml).

## Links
* [nginx.org: archive of mainline packages for RHEL6](http://nginx.org/packages/mainline/rhel/6/x86_64/RPMS/)
* [xkyle.com: Getting Started With SPDY on Nginx (12th May 2013)](https://xkyle.com/getting-started-with-spdy-on-nginx/)
* [vagrantup.com](http://www.vagrantup.com/)

## License
Copyright 2014 by Jan Philipp. This build setup is licensed for free use (MIT). The binary stuff not, of course.