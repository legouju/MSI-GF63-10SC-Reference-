/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20210930 (32-bit version)
 * Copyright (c) 2000 - 2021 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of T:/hackintosh/msi g53/ssdts/custom dgpu patching/SSDT-PTSWAK.aml, Sat Dec 25 13:58:14 2021
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000000FD (253)
 *     Revision         0x02
 *     Checksum         0xF9
 *     OEM ID           "hack"
 *     OEM Table ID     "_PTSWAK"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200110 (538968336)
 */
DefinitionBlock ("", "SSDT", 2, "hack", "_PTSWAK", 0x00000000)
{
    External (_SB_.PCI0.PEG1.PEGP._OFF, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.PEG1.PEGP._ON_, MethodObj)    // 0 Arguments
    External (ZPTS, MethodObj)    // 1 Arguments
    External (ZWAK, MethodObj)    // 1 Arguments

    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        If (CondRefOf (\_SB.PCI0.PEG1.PEGP._ON))
        {
            \_SB.PCI0.PEG1.PEGP._ON ()
        }

        ZPTS (Arg0)
    }

    Method (_WAK, 1, NotSerialized)  // _WAK: Wake
    {
        If (((Arg0 < One) || (Arg0 > 0x05)))
        {
            Arg0 = 0x03
        }

        Local0 = ZWAK (Arg0)
        If (CondRefOf (\_SB.PCI0.PEG1.PEGP._OFF))
        {
            \_SB.PCI0.PEG1.PEGP._OFF ()
        }

        Return (Local0)
    }
}

