
class oscar {
  $target_osc = '/var/lib/tomcat6/webapps/Oscar10_12.war'
  $target_doc = '/var/lib/tomcat6/webapps/OscarDocument.war'
  $target_conf = '/usr/share/tomcat6/Oscar10_12.properties'
  $uri = "http://downloads.sourceforge.net/project/oscarmcmaster/Oscar%20McMaster%20Manual%20Install/10.12/oscar_mcmaster_10.12_1.2.final.tar.gz"
  $db_name=oscar_10_12
  $db_password=mysql

  exec { "wget_oscar":
    path => "/bin:/usr/bin",
    timeout     => 1800,
    command => "wget $uri -qO /home/vagrant/oscar.tar.gz",
  }

  exec { "unzip_oscar":
    subscribe => Exec["wget_oscar"],
    refreshonly => true,
    path => "/bin:/usr/bin",
    command => "tar xvfz /home/vagrant/oscar.tar.gz -C /home/vagrant",
  }

  exec { "move_osc":
    subscribe => Exec["unzip_oscar"],
    refreshonly => true,
    path => "/bin:/usr/bin",
    command => "mv /home/vagrant/oscar_mcmaster_10.12_/Oscar10_12.war $target_osc",
  }

  exec { "move_doc":
    subscribe => Exec["unzip_oscar"],
    refreshonly => true,
    path => "/bin:/usr/bin",
    command => "mv /home/vagrant/oscar_mcmaster_10.12_/OscarDocument.war $target_doc",
  }

  exec { "move_conf":
    subscribe => Exec["unzip_oscar"],
    refreshonly => true,
    path => "/bin:/usr/bin",
    command => "mv /home/vagrant/oscar_mcmaster_10.12_/Oscar10_12.properties $target_conf",
  }


  exec { "mysql_create_db":
    subscribe => Exec["move_conf"],
    refreshonly => true,
    path => "/bin:/usr/bin",
    command => "mysqladmin -uroot -p$db_password create $db_name",
  }

  exec { "mysql_write_data":
    subscribe => Exec["mysql_create_db"],
    refreshonly => true,
    path => "/bin:/usr/bin",
    command => "mysql -uroot -p$db_password $db_name < /home/vagrant/oscar_mcmaster_10.12_/OscarON10_12.sql",
  }

}
