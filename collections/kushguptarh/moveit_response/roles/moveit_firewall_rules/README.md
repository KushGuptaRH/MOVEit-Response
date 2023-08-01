Role Name
=========

This role intends to disable all inbound and outbound HTTP and HTTPS traffic to a MOVEit Transfer environment through Firewall Rules 


Requirements
------------

One module is being used in this role, community.windows.win_firewall_rule. Make sure you have access to this module. This role also relies on a 'firewall_rule_state' variable that determines what state you want the rules to be in. Options are 'present' and 'absent' for this variable. 

Role Variables
--------------

moveit_firewall_rules_list:
  - A list of dictionary items listing the name, port, and direction of which firewall rules to establish
  - Located in vars/main.yml 

moveit_firewall_rules_state:
  - Determines what state you want the firewall rules to be in.
  - Options are 'present' and 'absent' for this variable.
  - Located in vars/main.yml

Dependencies
------------

Relies on the two variables listed above and the community.windows.win_firewall_rule module. A WinRM connection mechanism must be established to authenticate on Windows machines.

Example Playbook
----------------

    - hosts: MOVEit-servers
      roles:
         - role: kushguptarh.moveit_firewall_rules

License
-------

BSD-3-Clause

Author Information
------------------

https://www.redhat.com/en/authors/kush-gupta