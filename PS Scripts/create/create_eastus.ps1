
$i=1
while($i -lt 12)
{
$i++
	az vm create --resource-group main --name eeastus-f16-0$i --image UbuntuLTS --size Standard_F16 --admin-username master --admin-password Iamroot786786 --location eastus

}