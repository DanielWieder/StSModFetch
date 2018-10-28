# Download the latest slay the spire mods from Github

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# The path of the STS mods folder. This uses the steam path by default.
$stsPath = "C:\Program Files (x86)\Steam\steamapps\common\SlayTheSpire"
$modPath = "$stsPath\mods\"
$dataPath = "$modPath\sts-mod-data.txt"

# The repos and files to download from.
# The first entry is the version of this file. This must be changed whenever a mod is added/removed.
# The second is the data for ModTheSpire. 
# After is the data of the various mods
$data =  	
			('DanielWieder/StSModFetch', 			'fetch-sts-mods.ps1', 		'1.0'),
			('kiooeht/ModTheSpire', 				'ModTheSpire.zip', 			''),
			('GraysonnG/RelicSorter', 				'RelicSorter.jar', 			''),
			('ReinaSHSL/StS-RNG', 					'RNG.jar', 					''),
			('daviscook477/BaseMod', 				'BaseMod.jar', 				''),
			('MurderousDuck/FetchMod',				'FetchMod.jar', 			''),
			('kiooeht/StSLib', 						'StSLib.jar', 				''),
			('AstroPenguin642/Replay-the-Spire', 	'ReplayTheSpireMod.jar', 	''),
			('kiooeht/Hubris', 						'Hubris.jar', 				''),
			('blakkthunderr/Blakkmod', 				'BlakkMod.jar', 			''),
			('twanvl/sts-shop-mod', 				'ShopMod.jar', 				''),
			('Modernkennnern/STS_AlwaysWhale', 		'STS_AlwaysWhale-0.1.0.jar',''),
			('Moocowsgomoo/StS-ConstructMod', 		'ConstructMod.jar', 		''),
			('JohnnyDevo/The-Mystic-Project', 		'TheMystic.jar', 			''),
			('fiiiiilth/BeakedTheCultist-StS', 		'BeakedTheCultist.jar', 	''),
			('GraysonnG/InfiniteSpire', 			'InfiniteSpire.jar', 		''),
			('twanvl/sts-conspire', 				'Conspire.jar', 			''),
			('GraysonnG/MimicMod', 					'MimicMod.jar', 			'') | ForEach-Object {[pscustomobject]@{repo = $_[0]; file = $_[1]; version = $_[2]}}
		
# Load saved metadata		
if ([System.IO.File]::Exists($dataPath)) {
	$storedData = Get-Content -Path $dataPath | ConvertFrom-Json	

	if ($data[0].version -eq $storedData[0].version) {
		$data = $storedData;
	}
}

# Add the mods directory if it doesn't exist
if (-NOT ([System.IO.File]::Exists($modPath))) {
	New-Item -ItemType Directory -path $modPath
}

function download($mod, $path) {
	$repo = $mod.repo;
	$file = $mod.file;

	$releases = "https://api.github.com/repos/$repo/releases"
	$version = (Invoke-WebRequest $releases -UseBasicParsing -Headers $Headers | ConvertFrom-Json)[0].tag_name
	
	if (-NOT ($version -eq $mod.version)) {
		$source = "https://github.com/$repo/releases/download/$version/$file"
		$destination = "$path$file"
		Write-Host Downloading:	$mod.repo $version
		Invoke-WebRequest $source -Out $destination -Headers $Headers
		$mod.version = $version 
		
		# If the mod was successfully downloaded then update the version number
		if($?)
		{
			$mod.version = $version 
		}
	}
}

# Download all of the mods
download $data[1] $stsPath

$mtsFile = $data[1].file;
Expand-Archive "$stsPath/$mtsFile" -DestinationPath $stsPath -Force

for ($i = 2; $i -lt $data.Length; $i++){
	download $data[$i] $modPath
}

$data | ConvertTo-Json | Set-Content -Path $dataPath	