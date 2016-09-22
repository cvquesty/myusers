# Defined Type to create a user in MySQL
#
define  myusers::create::user (

  $dbauth,
  $dbauthpw,
  $user,
  $password,
  $database,
  $location,
  $system,

) {

  exec { 'create_user':
    command => "/usr/bin/mysqladmin -u ${dbauth} -p ${dbauthpw} -e \"CREATE USER ${user} ON ${database}.*\"",
  }

}
