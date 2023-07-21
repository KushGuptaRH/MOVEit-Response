Role Name
=========

This role checks and fails if the hosts it is running on are not Windows Servers and do not have a MiCentralCFG.exe (main execution) 


Requirements
------------

Two modules are being used in this role, ansible.windows.win_stat and ansible.builtin.fail. Make sure you have access to both. This role also relies on ansible_facts['os_family'], so make sure your facts are turned on/cached.

Role Variables
--------------

ansible_facts['os_family']:
  - Ansible Facts mechanism for determining Windows systems
MOVEit_path: 
  - Defaults to the default path of the MOVEit server documentation, C:\Program Files\MOVEit\MiCentralCFG.exe. 
  - Can be set to whatever drive/directory you want to check for the MOVEit Executable. 
  - Stored in defaults/main.yml

Dependencies
------------

Relies on a specific Ansible Fact, ansible.builtin and ansible.windows modules. A WinRM connection mechanism must be established to authenticate on Windows machines.

Example Playbook
----------------

    - hosts: Suspected-MOVEit-servers
      roles:
         - role: kushguptarh.moveit_server_check

License
-------

BSD-3-Clause

Author Information
------------------

https://www.redhat.com/en/authors/kush-gupta