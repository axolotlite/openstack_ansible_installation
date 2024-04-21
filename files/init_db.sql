SET PASSWORD FOR 'root'@'localhost' = PASSWORD('password');
# Kill the anonymous users
REVOKE ALL PRIVILEGES, GRANT OPTION FROM ''@'%';
# Make our changes take effect
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param
#keystone
create database keystone;
grant all privileges on keystone.* to keystone@'localhost' identified by 'password';
grant all privileges on keystone.* to keystone@'%' identified by 'password';
# glance
create database glance;
grant all privileges on glance.* to glance@'localhost' identified by 'password';
grant all privileges on glance.* to glance@'%' identified by 'password';
# placement
create database placement;
grant all privileges on placement.* to placement@'localhost' identified by 'password';
grant all privileges on placement.* to placement@'%' identified by 'password';
# nova
create database nova_api;
create database nova;
create database nova_cell0;
grant all privileges on nova.* to nova@'localhost' identified by 'password';
grant all privileges on nova.* to nova@'%' identified by 'password';
grant all privileges on nova_api.* to nova@'localhost' identified by 'password';
grant all privileges on nova_api.* to nova@'%' identified by 'password'
grant all privileges on nova_cell0.* to nova@'localhost' identified by 'password';
grant all privileges on nova_cell0.* to nova@'%' identified by 'password';
# neutron
create database neutron;
grant all privileges on neutron.* to neutron@'localhost' identified by 'password';
grant all privileges on neutron.* to neutron@'%' identified by 'password';
flush privileges;
