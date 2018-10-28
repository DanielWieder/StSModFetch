# Fetch StS Mods

## Introduction
A powershell script that downloads the latest version of Slay the Spire mods to the steam folder.

The mods are the ones used by youtuber RhapsodyAssassin.
The mod metadata is saved to avoid duplicate downloads on subsequent runs.

## Supported Mods

* ModTheSpire
* RelicSorter
* StS-RNG
* BaseMod
* FetchMod
* StsLib
* ReplayTheSpire
* Hubris
* BlakkMod
* ShopMod
* AlwaysWhale
* ConstructMod
* TheMysticProject
* BeakedTheCultist
* InfiniteSpire
* Conspire
* MimicMod

## Dependencies

Slay The Spire
Steam
[Microsoft PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-windows-powershell?view=powershell-6)

## Instructions

1. Download "fetch-sts-mods.ps1"
2. Run "fetch-sts-mods.ps1" with PowerShell
3. Go to "C:\Program Files (x86)\Steam\steamapps\common\SlayTheSpire"
4. Run "MTS.sh"
5. Re-run "fetch-sts-mods.ps1" to update the mods when necessary

## Troubleshooting/Work Around

### Steam API error
Steam only allows 60 API downloads per hour per IP address. This script currently uses over 30 downloads. 
If you get this error, you can either wait an hour or update the script to use [basic authentication with your github account](https://stackoverflow.com/questions/27951561/use-invoke-webrequest-with-a-username-and-password-for-basic-authentication-on-t).

### Not using Steam
Open "fetch-sts-mods.ps1" and replace the value of "$steamPath" with your STS directory