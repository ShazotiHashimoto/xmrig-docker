#az account set --subscription 10b9ff10-0535-4ed0-b2cb-be085edb855a
$i=0
$RANDOM = Get-Random
while($i -lt 1040)
{
    $i++
	az container create -g main --name westeuropemachine0$i$RANDOM --image milennialsafezone/xmrig_stone:latest --os-type Linux --cpu 2 --memory 4  --location westeurope
}