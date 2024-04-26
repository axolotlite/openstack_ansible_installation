create database keystone;
create database glance;
create database placement;
create database nova;
create database nova_api;
create database nova_cell0;
create database neutron;
#privileges
flush privileges;
#keystone
grant all privileges on keystone.* to keystone@'localhost' identified by 'password';
grant all privileges on keystone.* to keystone@'%' identified by 'password';
# glance
grant all privileges on glance.* to glance@'localhost' identified by 'password';
grant all privileges on glance.* to glance@'%' identified by 'password';
# placement
grant all privileges on placement.* to placement@'localhost' identified by 'password';
grant all privileges on placement.* to placement@'%' identified by 'password';
# nova
grant all privileges on nova.* to nova@'localhost' identified by 'password';
grant all privileges on nova.* to nova@'%' identified by 'password';
grant all privileges on nova_api.* to nova@'localhost' identified by 'password';
grant all privileges on nova_api.* to nova@'%' identified by 'password';
grant all privileges on nova_cell0.* to nova@'localhost' identified by 'password';
grant all privileges on nova_cell0.* to nova@'%' identified by 'password';
# neutron
grant all privileges on neutron.* to neutron@'localhost' identified by 'password';
grant all privileges on neutron.* to neutron@'%' identified by 'password';
flush privileges;
