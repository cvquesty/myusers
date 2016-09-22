## Overview

This is an add-on moudle to the puppetlabs-mysql module (required) to administer users on a MySQL database. It utilizes defined types to act on pre-existing databases & tables you have already created using the puppetlabs-mysql module.

There are several modes of use.

You can call the defined types from a calling profile:

class profiles::addstuff {

$user   = hiera('variableforuser')
$system = hiera('variableforsystem')

  myusers::create::user { 'user':
    user => $user,
    system => $system,
  }

}

You can also call the routine randomly from anywhere else:


class foo {

  myusers::create::user { 'bob':
    user   => 'bob',
    system => 'localhost',
  }

}

## Applying grants

Once you have created the users you wish to have, you can then apply grants to them. If the user is meant to be a "readonly" user, you can call that grant directly.  Again, from a profile:

class profiles::grantstuff {

$dbauth   = hiera('dbauth')
$dbauthpw = hiera('dbauthpw')
$user     = hiera('variableforuser')
$password = hiera('variableforpassword')
$database = 'database' (or hiera('variablefordatabase')
$location = 'location' (or hiera('variableforlocation')

  myusers::grant::readonly { 'bob':
    dbauth   => $dbauth,
    dbauthpw => $dbauthpw,
    user     => $user,
    password => $password,
    database => $database,
    location => $location,
  }

}

Or, as you would expect, you can call it directly and supply values as needed:

  myusers::grant::reasdwrite { 'bob':
    dbauth   => 'root',
    dbauthpw => 'rootpw',
    user     => 'bob',
    password => 'bobpass',
    database => 'foodata',
    location => 'localhost',
  }

## Usage

As you can see, you can pass in the variables from the parent profile, having done Hiera lookups there.  Or, you can explicitly call one of the routines and manually passs each option into the parameters so the defined type can do its job.
