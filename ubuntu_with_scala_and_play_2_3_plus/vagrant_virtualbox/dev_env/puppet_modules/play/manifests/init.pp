
define play::framework() {
	
	$play_dirs = [ '/vagrant/dev_env/', '/vagrant/dev_env/deps', '/vagrant/dev_env/deps/play']
	$play_dir = '/vagrant/dev_env/deps/play'

	file { $play_dirs:
		ensure => directory,
		owner => 'vagrant',
		group => 'vagrant',
		recurse => true,
	}	

	package { 'unzip':
		ensure => installed
	}

	exec { 'download_play':
		command => '/usr/bin/wget http://downloads.typesafe.com/typesafe-activator/1.2.10/typesafe-activator-1.2.10-minimal.zip',
		cwd => $play_dir,
		require => Package['unzip'],
		creates => "${play_dir}/activator-1.2.10-minimal",
		user => 'vagrant',
		group => 'vagrant'
	}

	exec { 'unzip_play':
		command => '/usr/bin/unzip -o typesafe-activator-1.2.10-minimal.zip',
		cwd => $play_dir,
		require => Exec['download_play'],
		creates => "${play_dir}/play-2.3.4/activator-1.2.10-minimal",
		user => 'vagrant',
		group => 'vagrant'
	}

	file { '/usr/bin/activator':
		ensure => 'link',
		target => "${play_dir}/activator-1.2.10-minimal/activator",
		owner => 'vagrant',
		group => 'vagrant',
		require => Exec['unzip_play']
	}

}

