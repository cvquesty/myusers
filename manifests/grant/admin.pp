# Defined type to create admin user
#
define myusers::grant::admin (

$dbauth,      # DB Admin username
$dbauthpw,    # DB Admin Password
$user,        # User being granted permissions
$password,    # User's Password being granted permissions
$database,    # Database Permissions being granted on
$location,    # Location from which user being granted permissions (localhost, *.*, etc.)

) {

  exec { 'create_admin_user':
    unless  => "/usr/bin/mysqladmin -u ${user} -p ${password} status",
    command => "/usr/bin/mysqladmin -u ${dbauth} -p ${dbauthpw} -e \"GRANT ALL ON ${database}.* TO \'${user}\'@\'${location}\' IDENTIFIED BY ${password}; flush privileges;\"",
  }

}
