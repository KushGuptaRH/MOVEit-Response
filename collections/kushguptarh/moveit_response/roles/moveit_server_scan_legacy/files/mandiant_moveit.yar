rule M_Webshell_LEMURLOOT_DLL_1 {

    meta:

        disclaimer = "This rule is meant for hunting and is not tested to run in a production environment"

        description = "Detects the compiled DLLs generated from human2.aspx LEMURLOOT payloads."

        sample = "c58c2c2ea608c83fad9326055a8271d47d8246dc9cb401e420c0971c67e19cbf"

        date = "2023/06/01"

        version = "1"

    strings:

        $net = "ASP.NET"

        $human = "Create_ASP_human2_aspx"

        $s1 = "X-siLock-Comment" wide

        $s2 = "X-siLock-Step3" wide

        $s3 = "X-siLock-Step2" wide

        $s4 = "Health Check Service" wide

        $s5 = "attachment; filename={0}" wide

    condition:

        uint16(0) == 0x5A4D and uint32(uint32(0x3C)) == 0x00004550 and

        filesize < 15KB and

        $net and

        (

            ($human and 2 of ($s*)) or

            (3 of ($s*))

        )

}

rule M_Webshell_LEMURLOOT_1 {

    meta:

        disclaimer = "This rule is meant for hunting and is not tested to run in a production environment"

        description = "Detects the LEMURLOOT ASP.NET scripts"

        md5 = "b69e23cd45c8ac71652737ef44e15a34"

        sample = "cf23ea0d63b4c4c348865cefd70c35727ea8c82ba86d56635e488d816e60ea45x"

        date = "2023/06/01"

        version = "1"

    strings:

        $head = "<%@ Page"

        $s1 = "X-siLock-Comment"

        $s2 = "X-siLock-Step"

        $s3 = "Health Check Service"

        $s4 = /pass, \"[a-z0-9]{8}-[a-z0-9]{4}/

        $s5 = "attachment;filename={0}"

    condition:

        filesize > 5KB and filesize < 10KB and

        (

            ($head in (0..50) and 2 of ($s*)) or

            (3 of ($s*))

        )

}