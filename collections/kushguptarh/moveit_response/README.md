# MOVEit-Response 

### Created as a proof of concept to show how Ansible can automate tasks to help mitigate and analyze Windows MOVEit servers

 - **SHOULD NOT BE RUN** without prior validation, testing, reading, and testing through the playbook/collections. 
- Testing is currently happening on a MOVEit server thanks to [Emergent, LLC](https://www.emergent360.com/).
- MOVEit is software and a registered trademark of Progress Software Corporation.
- An extensive timeline can be found [here](https://www.cybersecuritydive.com/news/moveit-breach-timeline/687417/) if all this sounds new
<br>

This playbook will **not** be able to do all the remediation steps to the MOVEit application itself since the API will be down. It can still do a lot with the Windows system itself to immediately take the recommended mitigation steps and do some verification.
<br>
<br>

Check out Progress Software's first security notice [here](https://www.progress.com/security/moveit-transfer-and-moveit-cloud-vulnerability), the second [here](https://community.progress.com/s/article/MOVEit-Transfer-2020-1-Service-Pack-July-2023), and a really great MOVEit security guide [here](https://www.mandiant.com/resources/reports/moveit-transfer-containment-and-hardening-guide) by Mandiant.
<br>
<br>Between May 31 and July 6, six distinct vulnerabilities (4 critical, 2 high) have been reported that are affecting MOVEit Transfer and MOVEit Cloud. The most recent updates include the following:
<br>

> July, 2023, ...In response to recent customer feedback, we are formalizing a regular Service Pack program for MOVEit products, including MOVEit Transfer and MOVEit Automation... This limited Service Pack contains fixes for three newly disclosed CVEs... Progress Software highly recommends you apply this Service Pack for product updates and security improvements.

<br>

> June 18, 2023, ...Our product teams and third-party forensics partner have reviewed the vulnerability and associated patch and have deemed that the issue has been addressed. This fix has been applied to all MOVEit Cloud clusters and is available for MOVEit Transfer customers.

<br>

> June 15, 2023, ...a third-party publicly posted a new SQLi vulnerability. We have taken HTTPs traffic down for MOVEit Cloud in light of the newly published vulnerability and are asking All MOVEit Transfer customers to immediately take down their HTTP and HTTPs traffic to safeguard their environments while the patch is finalized. We are currently testing the patch and we will update customers shortly.

<br>

MOVEit Transfer Critical Vulnerability (May 31, 2023) [CVE-2023-34362](https://community.progress.com/s/article/MOVEit-Transfer-Critical-Vulnerability-31May2023)
<br>
<br>MOVEit Transfer Critical Vulnerability (June 9, 2023) [CVE-2023-35036](https://community.progress.com/s/article/MOVEit-Transfer-Critical-Vulnerability-CVE-2023-35036-June-9-2023)
<br>
<br>MOVEit Transfer Critical Vulnerability (June 15, 2023) [CVE-2023-35708](https://community.progress.com/s/article/MOVEit-Transfer-Critical-Vulnerability-15June2023)
<br>
<br>MOVEit Transfer Service Pack for 1 Critical and 2 High CVEs (July, 2023) [CVE-2023-36934, CVE-2023-36932, CVE-2023-36933](https://community.progress.com/s/article/MOVEit-Transfer-2020-1-Service-Pack-July-2023)


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
     - Delete **any** instances of the human2.aspx (or any files with human2 prefix) and .cmdline script files.
     - On the MOVEit Transfer server, look for any new files created in the C:\MOVEitTransfer\wwwroot\ directory.
     - On the MOVEit Transfer server, look for new files created in the C:\Windows\TEMP\[random]\ directory with a file extension of [.]cmdline
     - On the MOVEit Transfer server, look for new APP_WEB_[random].dll files created in the C:\Windows\Microsoft. NET\Framework64\[version]\Temporary ASP .NET Files\root\[random]\[random]\ directory:
     - Stop IIS (iisreset /stop)
       - Delete all APP_WEB_[random].dll files located in C:\Windows\Microsoft. NET\Framework64\[version]\Temporary ASP. NET Files\root\[random]\[random]\
     - Start IIS (iisreset /start). Note: The next time the web application is accessed, it will be rebuilt properly. It is normal to have 1 APP_WEB_[random].dll file located in this directory.
    - Remove any unauthorized user accounts and all active sessions
    - Review logs
      
   b. [Reset Service Account Credentials](https://community.progress.com/s/article/Transfer-Automation-Change-Windows-Service-Account-Password)

 3. [Apply the first May 31 Patch - available with v12.1 or later](https://community.progress.com/s/article/MOVEit-Transfer-Critical-Vulnerability-31May2023)

 4. Verification
    - To confirm the files have been successfully deleted and no unauthorized accounts remain, follow steps 2a again. If you do find indicators of compromise, you should reset the service account credentials again.

 5. Refer to MOVEit Transfer Critical Vulnerability – [CVE-2023-35708](https://community.progress.com/s/article/MOVEit-Transfer-Critical-Vulnerability-15June2023) (June 15, 2023) to apply the next vulnerability fixes.

 6. Refer to MOVEit Transfer Service Pack for 1 Critical and 2 High CVEs - [CVE-2023-36934, CVE-2023-36932, CVE-2023-36933](https://community.progress.com/s/article/MOVEit-Transfer-2020-1-Service-Pack-July-2023) (July, 2023) to apply the next fixes after that. 
