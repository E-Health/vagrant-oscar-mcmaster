class jdk {
    package { "jdk":
        ensure => "installed",
        name => "openjdk-7-jdk",
    }
    file { "/etc/profile.d/java_env.sh":
        ensure => present,
        source => "puppet:///modules/jdk/java_env.sh",
        owner => "root",
        group => "root",
        mode => 755,
    }
    package { "default-jre-headless": 
        ensure => installed,
    }    
    package { "libmysql-java": 
        ensure => installed,
    }    
}
