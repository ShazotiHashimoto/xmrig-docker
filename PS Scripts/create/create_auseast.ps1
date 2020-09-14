
$i=13
while($i -lt 18)
{
$iRandom = Get-Random -Maximum 999

	az vm create --resource-group main --name australiaeast-f16-0$i-$iRandom --image UbuntuLTS --size Standard_F16 --admin-username master --admin-password Iamroot786786 --location australiaeast
	$i++

}