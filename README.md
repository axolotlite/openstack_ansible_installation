# Openstack Installation using Ansible

This project is a proof of concept, I've manually installed Openstack, wrote some scripts to automatically install it and finally, I've poured this experience into applying those script into Ansible modules in their respective roles to automate a basic install of Openstack.

This installation script currently hard-codes most of the process, however it should be easy to convert to variables since I've written some modular roles(aside from the horizon role).

### Directory overview

```
.
├── ansible.cfg
├── files
├── inventory
│   └── hosts.ini
├── main.yml
└── roles
    ├── add_line
    ├── append_block
    ├── append_line
    ├── config_databases
    ├── create_service
    ├── glance
    ├── horizon
    ├── keystone
    ├── neutron
    ├── nova
    ├── placement
    ├── prepend_line
    └── prereqs
```

after setting up your inventory file:
```
[servers]
<ip address> ansible_user="root" ansible_ssh_private_key_file="<ssh key>"
```

You'll need to setup mariadb on the target host, either through `mariadb-secure-installation` to set the root password as `root`, or entering mysql and changing it through:
```
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';

flush privileges;
```
#### Component roles:
each component roles has a configuration file containing the config blocks for each of its sections
for example `roles/placement/defaults/main.yml`
each key belongs to a specific section in the `/etc/placement/placement.conf` file, and using `blockinfile` module, I place the corresponding section into its respective place.
```
placement_configs:
  api: |
      auth_strategy = keystone
  DEFAULT: |
      debug = false
  keystone_authtoken: |
      www_authenticate_uri = http://controller:5000
      auth_url = http://controller:5000
      memcached_servers = controller:11211
      auth_type = password
      project_domain_name = default
      user_domain_name = default
      project_name = service
      username = placement
      password = servicepassword
  placement_database: |
      connection = mysql+pymysql://placement:password@controller/placement
```
a more modular way is to place the filename within the variable definition, allowing it to acquire both the blocks and file in an orderly fashion, reducing the written code within the module.

#### Auxiliary roles:
These roles are repeated tasks that are shared across components, I've placed them within their respective roles.

```
roles
    ├── append_block
    ├── append_line
    ├── create_service
    └── prepend_line
```
Usage:
- append_block:
```
filepath: the location of the file to edit
component_config: the variable name containing the configuration section and block
```
- append_line:
```
filepath: the location of the file to edit
insert_after: regex to find the line after which it can insert
regexp: another method to identify a line
line: the line to be inserted into the file
```
- create_service:
```
username: the keystone username used for this specific service
userpassword: the keystone password used for the service
projectname: the openstack project name for the service
servicename: the service name used to create an openstack service
servicetype: the openstack service type
servicedescription: a short description
endpointurl: the endpoint url to reach this service (the code automatically creates public, internal & admin endpoints)
```
- prepend_line: (will later be replaced with append_block)
```
filepath: the location of the file to edit
insertbefore: regex to find the line before which it can insert
regexp: another method to identify a line
line: the line to be inserted into the file
```
