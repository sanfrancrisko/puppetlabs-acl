$acls = hiera_hash('acls', {})

notify { $acls: }
create_resources(acl, $acls)

$tempAcl = Acl['tempdir']

acl { 'c:/temp':
  ensure      => present,
  permissions => [
    {
      identity => 'Administrators',
      rights   => [full]
    }
  ],
  owner       => 'Administrators',
  inherit_parent_permissions => true
}

acl { 'temp_dir_module_name':
  target      => 'c:/temp',
  ensure      => present,
  permissions => [
    {
      identity => 'bob',
      rights   => [read,execute]
    },
    {
      identity => 'tim',
      rights   => [read,execute]
    }
  ],
}

acl { 'temp_dir_module2_name':
  target      => 'c:/temp',
  ensure      => present,
  permissions => [
    {
      identity => 'bill',
      rights   => [full],
      affects  => self_only
    }
    ,
    {
      identity => 'tim',
      rights   => [read,execute]
    }
  ],
}

$tempAcl2 = Acl['c:/temp']

# $foo = inline_template("<% require 'pry';binding.pry %>")