Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

stage { 'first':
    before => Stage['second'],
}

stage { 'second':
    before => Stage['third']
}

stage { 'third':
    before => Stage['fourth']
}

stage { 'fourth':
    before => Stage['main']
}

class { "apt_get::update":
    stage  => first,
}

class { "jdk":
    stage => second,
}

class { "tomcat":
    stage => third,
}

class { "mysql":
    stage => fourth,
}


include apt_get::update
include jdk
include vim
include mysql
include tomcat
include openmrs
include oscar
