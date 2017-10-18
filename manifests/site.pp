## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# Disable filebucket by default for all File resources:
File { backup => false }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

# Handle missing wheel group in oses that don't have it to keep minor error
# out of agent runs

if $facts['os']['family'] == 'Debian' {
  group { 'wheel':
    ensure    => present,
    gid       => '10',
    allowdupe => true,
  }
}



#node 'pnewman422.mylabserver.com' {
#  include role::apache
#  notify { 'test-message-for-pnewman422':
#    message => 'This is pnewman422 using node definition.'
#  }
#
#}

node default {
  hiera_include('classes')
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
}
