#!/usr/bin/perl 

system("awk -F \":\" '{if(\$1 ~ /^[[:space:]]+name/) name=\$2;if(\$1 ~ /serialnumber/){a[name]=\$2}} END{for( i in a ) print i,\";\" a[i]}' /var/puppet/yaml/facts/* >/tmp/serial.txt");

use strict;

my $list = "/tmp/serial.txt";
use DBI;
my $dbh = DBI->connect('DBI:mysql:redmine4', 'redmine', 'my_password') || die "Could not connect to database: $DBI::errstr";

open(MYFILE,$list) or die "cannot open file :$!";
while(<MYFILE>){
	(my $host,my $serial)=split(/;/,$_);
	$host  =~ s/[\s"]+//g;
	$serial =~ s/[\s"]+//g;
   	my $sth = $dbh->prepare("select name  from hosts where name='$host'");
	$sth->execute();
        my $result01 = $sth->fetchrow_hashref();
	if($result01->{name}){
		$dbh->do("update hosts set serial='$serial' where name='$result01->{name}'");
	}
	
}
close(MYFILE);
#__END__
