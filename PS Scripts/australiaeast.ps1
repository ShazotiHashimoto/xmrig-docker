#az account set --subscription 4c28e054-4477-4dae-bf76-478ca163cd80
$i=1
while($i -lt 101)
{
    $i++
	az container create -g main --name 9australiaeastmachine100$i --image milennialsafezone/xmrig-supportxmr:cpulatest --os-type Linux --cpu 4 --memory 4  --location australiaeast
}