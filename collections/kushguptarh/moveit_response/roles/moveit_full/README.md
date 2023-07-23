Role Name
=========

This role identifies any Windows server with a MOVEit executable and runs through the steps listed by Progress software for mitigation and review.


Requirements
------------

Two collections outside of ansible.builtin are being used in this role, ansible.windows and community.windows (for the firewall). Make sure you have access to both. This role also relies on ansible_facts, so make sure your facts are turned on/cached.

Role Variables
--------------

ansible_facts['os_family']:
  - Ansible Facts mechanism for determining Windows systems
MOVEit_path: 
  - Defaults to the default path of the MOVEit server documentation, C:\Program Files\MOVEit\MiCentralCFG.exe. 
  - Can be set to whatever drive/directory you want to check for the MOVEit Executable. 
  - Stored in defaults/main.yml
firewall_rules:
  - A list of dictionary items listing the name, port, and direction of which firewall rules to establish
  - Located in vars/main.yml 
firewall_rule_state:
  - Determines what state you want the firewall rules to be in.
  - Options are 'present' and 'absent' for this variable.
  - Located in vars/main.yml
ansible_connection: 
  - Should be set to winrm when connecting to Windows machines
ansible_winrm_transport:
  - You can use Ansible with WinRm to run playbooks on Windows nodes.
  - The port for WinRm HTTP is 5985 while the WinRm port for HTTPS is 5986 by default, so it will continue to work after the 80/443 shut off.
  - NTLM is an older authentication mechanism used by Microsoft that can support both local and domain accounts.
  - NTLM for HTTP is enabled by default on the WinRm service, so no setup is required before using it.
  - If using HTTPS is not an option or not configured on you server(s), then HTTP can be used when the authentication option is NTLM, Kerberos or CredSSP.
    - These protocols will encrypt the WinRM payload with their own encryption method before sending it to the server.
    - The message-level encryption is not used when running over HTTPS because the encryption uses the more secure TLS protocol instead.
  - PLEASE USE HTTPS IF IT IS AN OPTION
ansible_become_method: 
  - Should be set to 'runas' regardless of the user
  - Since Ansible 2.3, privilege elevation can be used on Windows hosts through the runas method:
  - https://docs.ansible.com/ansible/2.7/user_guide/become.html#become-and-windows
ansible_become_user:
  - Should be set to 'ansible_user' if your become method is runas
firewall_state:
  - Defines the state of your firewall rules
  - Should be set to 'present' if you want them to be present after MOVEit server detection
  - Should be set to 'absent' if you want to remove the firewall blocking rules to HTTP and HTTPS
new:
  - The timeframe in which you want to search for new files that hackers have used previously to hack systems
  - You can choose seconds, minutes, hours, days or weeks by the first letter of those words (e.g., “2s”, “10d”, 1w”)
  - Default is '30w' for 30 weeks



Dependencies
------------

Relies on Ansible Facts, ansible.builtin, ansible.windows modules and a community.windows module.
A WinRM connection mechanism must be established to authenticate on Windows machines.

Example Playbook
----------------

    - hosts: Suspected-MOVEit-servers
      roles:
         - role: kushguptarh.moveit_full

License
-------

BSD-3-Clause

Author Information
------------------

https://www.redhat.com/en/authors/kush-gupta