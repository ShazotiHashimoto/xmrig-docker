#az account set --subscription 10b9ff10-0535-4ed0-b2cb-be085edb855a
$i=999
while($i -lt 1040)
{
    $i++
	az container create -g main --name westeuropemachine0$i --image shahzaadt/xmrig:v2 --os-type Linux --cpu 4 --memory 4  --location westeurope
}