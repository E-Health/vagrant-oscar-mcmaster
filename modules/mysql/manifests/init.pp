class mysql {
  $password = "mysql"
  package { "mysql-client": ensure => installed }
  package { "mysql-server": ensure => installed }
  package { "libmysqlclient-dev": ensure => installed }


  exec { "mysql_root_password":
    subscribe => [ Package["mysql-server"], Package["mysql-client"], Package["libmysqlclient-dev"] ],
    refreshonly => true,
    unless => "mysqladmin -uroot -p$password status",
    path => "/bin:/usr/bin",
    command => "mysqladmin -uroot password $password",
  }


}
