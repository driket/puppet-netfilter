class mv_netfilter::service {

	#service { "mv_netfilter":
	#	name => $mv_netfilter::service_name,
	#	ensure => running,
	#	require => Package["mv_netfilter"],
	#}
}
