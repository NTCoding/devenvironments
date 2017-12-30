
	exec { 'update_apt':
	    command => '/usr/bin/sudo apt-get update -y'
    }


	package { ['gdebi-core', 'openjdk-7-jre', 'openjdk-7-jdk', 'make', 'gcc']:
		ensure => installed,
		before => Exec['installSBT'],
		require => Exec['update_apt']
	}

	exec { 'retrieve_SBT':
		command => '/usr/bin/wget -q http://repo.scala-sbt.org/scalasbt/sbt-native-packages/org/scala-sbt/sbt/0.13.1/sbt.deb -O /home/vagrant/sbt.deb', 
		creates => '/home/vagrant/sbt.deb',
	}

	exec { 'installSBT':
		command => '/usr/bin/sudo /usr/bin/gdebi -n /home/vagrant/sbt.deb',
		require => Exec['retrieve_SBT']
	}

	play::framework{ 'play': }

	file { '/etc/motd':
		mode => 664,
		owner => 'vagrant',
		group => 'vagrant',
		content => '********  Welcome to scala dev environment use the "activator" command  
********'
	}

