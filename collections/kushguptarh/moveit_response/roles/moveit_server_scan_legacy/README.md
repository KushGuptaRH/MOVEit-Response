Role Name
=========

This role checks Windows hosts for files known to be associated with the MOVEit ransomware attacks. It does this by making sure chocolatey and yara are installed, copying over the yara rules specified in moveit_server_scan_rules to the C:\Temp\ directory, and then running the rules.


Requirements
------------

Four modules are being used in this role, all contained in ansible.windows and ansible.builtin.

Role Variables
--------------

moveit_server_scan_rules:
  - list of the yara rule files to run on the windows hosts

Dependencies
------------

Relies on a specific Ansible Fact, ansible.builtin and ansible.windows modules. A WinRM connection mechanism must be established to authenticate on Windows machines.

Example Playbook
----------------

    - hosts: Suspected-MOVEit-servers
      roles:
         - role: kushguptarh.moveit_server_scan

License
-------

BSD-3-Clause

Author Information
------------------

https://www.redhat.com/en/authors/kush-gupta