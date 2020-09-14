
$i=13
while($i -lt 18)
{

	az vm create --resource-group main --name australiaeast-f16-0$i --image UbuntuLTS --size Standard_F16 --admin-username master --admin-password Iamroot786786 --location australiaeast
	$i++

}