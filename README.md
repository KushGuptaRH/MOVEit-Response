# MOVEit-Response 

#### Created as a proof of concept to show how Ansible can automate tasks to help mitigate and analyze Windows MOVEit servers

**SHOULD NOT BE RUN** without prior validation, testing, reading, and testing through the playbook. 
<br>

Testing is currently happening on a MoveIT server thanks to [Emergent, LLC](https://www.emergent360.com/).
<br>
<br>This playbook will **not** be able to do all the remediation steps to the MOVEit application itself since the API will be down, but it can do a lot with the Windows system to immediately take the recommended mitigation steps and do some verification.
<br>
<br>Check out Progress Software's security notice [here](https://www.progress.com/security/moveit-transfer-and-moveit-cloud-vulnerability).
<br>
<br>Between May 31 and June 15, three distinct vulnerabilities have been reported that are affecting MOVEit Transfer and MOVEit Cloud.
<br>
<br>"June 18, 2023,...Our product teams and third-party forensics partner have reviewed the vulnerability and associated patch and have deemed that the issue has been addressed. This fix has been applied to all MOVEit Cloud clusters and is available for MOVEit Transfer customers."
<br>
<br>
"June 15, 2023, Today, a third-party publicly posted a new SQLi vulnerability. We have taken HTTPs traffic down for MOVEit Cloud in light of the newly published vulnerability and are asking All MOVEit Transfer customers to immediately take down their HTTP and HTTPs traffic to safeguard their environments while the patch is finalized. We are currently testing the patch and we will update customers shortly."
<br>
<br>
MOVEit Transfer Critical Vulnerability (May 31, 2023) [CVE-2023-34362](https://community.progress.com/s/article/MOVEit-Transfer-Critical-Vulnerability-31May2023)
<br>
<br>MOVEit Transfer Critical Vulnerability (June 9, 2023) [CVE-2023-35036](https://community.progress.com/s/article/MOVEit-Transfer-Critical-Vulnerability-CVE-2023-35036-June-9-2023)
<br>
<br>MOVEit Transfer Critical Vulnerability (June 15, 2023) [CVE-2023-35708](https://community.progress.com/s/article/MOVEit-Transfer-Critical-Vulnerability-15June2023)





## Recommended Remediation
1. Disable all HTTP and HTTPs traffic to your MOVEit Transfer environment
- It is important to note, that until HTTP and HTTPS traffic is enabled again: 
  - Users will not be able to log on to the MOVEit Transfer web UI  
  - MOVEit Automation tasks that use the native MOVEit Transfer host will not work
  - REST, Java and .NET APIs will not work 
  - MOVEit Transfer add-in for Outlook will not work 
- SFTP and FTP/s protocols will continue to work as normal 

2. Review, Delete and Reset
   
   a. Delete Unauthorized Files and User Accounts
   - Delete any instances of the human2.aspx (or any files with human2 prefix) and .cmdline script files.
   - On the MOVEit Transfer server, look for any new files created in the C:\MOVEitTransfer\wwwroot\ directory.
   - On the MOVEit Transfer server, look for new files created in the C:\Windows\TEMP\[random]\ directory with a file extension of [.]cmdline
   - On the MOVEit Transfer server, look for new APP_WEB_[random].dll files created in the C:\Windows\Microsoft. NET\Framework64\[version]\Temporary ASP .NET Files\root\[random]\[random]\ directory:
     - Stop IIS (iisreset /stop)
     - Delete all APP_WEB_[random].dll files located in C:\Windows\Microsoft. NET\Framework64\[version]\Temporary ASP. NET Files\root\[random]\[random]\
     - Start IIS (iisreset /start). Note: The next time the web application is accessed, it will be rebuilt properly. It is normal to have 1 APP_WEB_[random].dll file located in this directory.
    - Remove any unauthorized user accounts and all active sessions
    - Review logs
      
   b. Reset Service Account Credentials: https://community.progress.com/s/article/Transfer-Automation-Change-Windows-Service-Account-Password

 3. Apply the Patch - available with v12.1 or later: https://community.progress.com/s/article/MOVEit-Transfer-Critical-Vulnerability-31May2023

 4. Verification
 - To confirm the files have been successfully deleted and no unauthorized accounts remain, follow steps 2a again. If you do find indicators of compromise, you should reset the service account credentials again.

 5. Refer to MOVEit Transfer Critical Vulnerability – CVE-2023-35708 (June 15, 2023) to apply the latest vulnerability fixes: https://community.progress.com/s/article/MOVEit-Transfer-Critical-Vulnerability-15June2023
