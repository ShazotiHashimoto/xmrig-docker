#az account set --subscription 10b9ff10-0535-4ed0-b2cb-be085edb855a
$i=0
$RANDOM = Get-Random
while($i -lt 101)
{
    $i++
	az container create -g main --name southindiamachine0$i$RANDOM --image shahzaadt/xmrig:v2 --os-type Linux --cpu 4 --memory 4  --location southindia
}
