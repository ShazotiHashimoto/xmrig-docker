#az account set --subscription 4c28e054-4477-4dae-bf76-478ca163cd80
$i=0
$RANDOM = Get-Random
while($i -lt 101)
{
    $i++
	az container create -g main --name westusmachine0$i$RANDOM --image shahzaadt/xmrig:v2 --os-type Linux --cpu 4 --memory 4  --location westus
}