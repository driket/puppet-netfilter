define mv_netfilter::config::iptables (	$respong_to_ping  = 'true',
										$respond_to_established_connections  = 'true', 
										$input_policy = 'ACCEPT',
										$output_policy = 'ACCEPT',
										$forward_policy = 'ACCEPT',
										$input_rules = {},
										$output_rules = {},
										$forward_rules = {},
										$prerouting_rules = {},
										$postrouting_rules = {},
										$always_accept = {},
										) {
	require('mv_netfilter')
	require('mv_netfilter::packages')

	# setup iptables
    file { '/opt/setup_iptables.sh': 
        ensure => file,
        content => template("mv_netfilter/setup_iptables.sh.erb"),
        mode => "0755",
        owner => 'root',
        group => 'root',
		notify => Exec["setup_iptables.sh"],
    }	
		
    exec { "setup_iptables.sh":
         command => "/opt/setup_iptables.sh",
		 require => File["/opt/setup_iptables.sh"],
		 refreshonly => true,
    }
	
	# disable IP script (test purpose)
    file { '/opt/disable_iptables.sh': 
        ensure => file,
        content => template("mv_netfilter/disable_iptables.sh.erb"),
        mode => "0755",
        owner => 'root',
        group => 'root',
    }
}