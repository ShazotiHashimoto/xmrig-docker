
$i=1
while($i -lt 13)
{
$iRandom = Get-Random -Maximum 999
	az vm create --resource-group main --name uaenorth-f16-0$i-$iRandom --image UbuntuLTS --size Standard_F16 --admin-username master --admin-password Iamroot786786 --location uaenorth --public-ip-address """"
	$i++

}