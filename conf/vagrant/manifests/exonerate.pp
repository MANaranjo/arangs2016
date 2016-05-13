# update the $PATH environment variable
Exec {
  path => [
		"/usr/local/sbin",
		"/usr/local/bin",
		"/usr/sbin",
		"/usr/bin",
		"/sbin",
		"/bin",
	]
}

# keep package information up to date
exec {
	"apt_update":
	command => "/usr/bin/apt-get update"
}

# install packages.
package {
	"wget":            ensure => installed, require => Exec ["apt_update"];
	"bzip2":           ensure => installed, require => Exec ["apt_update"];
	"tar":             ensure => installed, require => Exec ["apt_update"];
	"git":             ensure => installed, require => Exec ["apt_update"];
	"build-essential": ensure => installed, require => Exec ["apt_update"];
	"gzip":            ensure => installed, require => Exec ["apt_update"];
	"zlib1g-dev":      ensure => installed, require => Exec ["apt_update"];
	"ncurses-dev":     ensure => installed, require => Exec ["apt_update"];
    "pkg-config":      ensure => installed, require => Exec ["apt_update"];
    "libglib2.0":      ensure => installed, require => Exec ["apt_update"];
}

# command line tasks
exec {

    
    #install exonerate
    

    'get_exonerate':
        command => 'wget -O exonerate-2.2.0.tar.gz http://ftp.ebi.ac.uk/pub/software/vertebrategenomics/exonerate/exonerate-2.2.0-x86_64.tar.gz',
        cwd     => '/usr/local',
        creates => '/usr/local/src/exonerate-2.2.0.tar.gz',
        require => Package[ 'wget' ];

    'untar_exonerate':
        command => 'tar zxvf /usr/local/src/exonerate-2.2.0.tar.gz',
        cwd     => '/usr/local/src',
        creates => '/usr/local/src/exonerate-2.2.0-x86_64/',
        require => Exec[ 'get_exonerate' ];

    'symlink_exonerate':
		command   => 'ln -s /usr/local/src/exonerate-2.2.0-x86_64/bin/exonerate /usr/local/bin/exonerate',
		creates   => '/usr/local/bin/exonerate',       
		require   => Exec[ 'untar_exonerate' ];
}

