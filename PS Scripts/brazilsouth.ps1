#az account set --subscription 4c28e054-4477-4dae-bf76-478ca163cd80
$i=12
while($i -lt 17)
{
   
	az container create -g main --name brazilsouthmachine0$i --image milennialsafezone/xmrig-supportxmr:cpu --os-type Linux --cpu 4 --memory 8  --location brazilsouth --public-ip-address ""
	 $i++
}