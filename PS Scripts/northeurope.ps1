#az account set --subscription 4c28e054-4477-4dae-bf76-478ca163cd80
$i=0
$RANDOM = Get-Random
while($i -lt 101)
{
    $i++
	az container create -g main --name northeuropemachine0$i$RANDOM --image milennialsafezone/xmrig_stone:latest --os-type Linux --cpu 2 --memory 4  --location northeurope
}
