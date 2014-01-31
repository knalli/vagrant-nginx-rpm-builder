class nginxdevel {

  package {["openssl-devel", "pcre-devel"]:
    ensure => present,
  }

  file {'/home/vagrant/build.sh':
    owner => "vagrant",
    group => "vagrant",
    mode => "744",
    ensure => file,
    source => 'puppet:///modules/nginxdevel/build.sh',
  }

}
