define mv_netfilter::config::iptables (	
	$respong_to_ping  	= 'true',
	$respond_to_established_connections  = 'true', 
	$input_policy 			= 'ACCEPT',
	$output_policy 			= 'ACCEPT',
	$forward_policy 		= 'ACCEPT',
	$input_rules 				= {},
	$output_rules 			= {},
	$forward_rules			= {},
	$prerouting_rules 	= {},
	$postrouting_rules 	= {},
	$always_accept 			= {},
) 
{
	require('mv_netfilter')
	require('mv_netfilter::packages')

  file { '/opt/mv_netfilter': 
		ensure => directory,
    mode => "0755",
    owner => 'root',
    group => 'root',
	}
	
  file { '/etc/init.d/mv-netfilter': 
		ensure 	=> file,
    content => template("mv_netfilter/mv-netfilter.erb"),
    mode 		=> "0755",
    owner		=> 'root',
    group 	=> 'root',
	}
	
	service { 'mv-netfilter':
		ensure 		=> 'running',
		require 	=> [
			File['/etc/init.d/mv-netfilter'],
			File['/opt/mv_netfilter/setup_iptables.sh'],
			File['/opt/mv_netfilter/disable_iptables.sh'],
		],
	}
	
  #exec { "setup_iptables.sh":
  #	command => "/opt/mv_netfilter/setup_iptables.sh",
	#	require => File["/opt/mv_netfilter/setup_iptables.sh"],
	#	refreshonly => true,
  #}
	
	# setup iptables
  file { '/opt/mv_netfilter/setup_iptables.sh': 
		ensure => file,
    content => template("mv_netfilter/setup_iptables.sh.erb"),
    mode => "0755",
    owner => 'root',
    group => 'root',
		notify => Service["mv-netfilter"],
  }	
	
	# disable IP script (test purpose)
  file { '/opt/mv_netfilter/disable_iptables.sh': 
  	ensure => file,
    content => template("mv_netfilter/disable_iptables.sh.erb"),
    mode => "0755",
    owner => 'root',
    group => 'root',
  }
}