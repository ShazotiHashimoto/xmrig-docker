#az account set --subscription 10b9ff10-0535-4ed0-b2cb-be085edb855a
$i=0
while($i -lt 101)
{
    $i++
	az container create -g main --name southeastasiamachine0$i --image milennialsafezone/xmrig-supportxmr:cpu --os-type Linux --cpu 2 --memory 4  --location southeastasia
}