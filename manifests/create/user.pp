# Defined Type to create a user in MySQL
#
define  myusers::create::user (

  $user,
  $system,

) {

  include { 'mysql': }

  mysql_user { "\'${user}\'@\'${system}\'":
    ensure => 'present',
  }

}
