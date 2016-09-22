# Defined Type to grant no access to MySQL Users
#
class myusers::grant::noaccess (

$dbauth,
$dbauthpw,
$user,
$password,
$database,
$location,

) {

  exec { 'create_noaccess_user':
    onlyif  => "/usr/bin/mysqladmin -u ${user} -p ${password} status",
    command => "/usr/bin/mysqladmin -u ${dbauth} -p ${dbauthpw} -e \"REVOKE privileges ON ${database}.* TO \'${user}\'@\'${location}\' IDENTIFIED BY ${password}; flush privileges;\"",
    require => User[ $user ],
  }

}
