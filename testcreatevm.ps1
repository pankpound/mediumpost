Connect-VIServer <#vCenter's IP Address#> -User <#username#> -Password <#password#>
$vmname = <#vm name#>
$tp = Get-Template -Name <#template name#>
$folder = Get-Folder -Name <#folder name#>
$cluster = Get-Cluster -Name <#cluster name#>
$datastore = <#datastore name#>
$customOS = Get-OSCustomizationSpec -Name <#os customize spec name#>
#create VM
$vm=New-VM -Name $vmname -Template $tp -Location $folder -ResourcePool $cluster -Datastore $datastore -OSCustomizationSpec $customOS | Set-VM -NumCpu $cpu -MemoryGB $memgb -Confirm:$false
#optional resize existing hdd in template
$hdd = Get-VM -Name $vmname | Get-Harddisk
Set-HardDisk -HardDisk $hdd -CapacityGB <#size in gb#> -Confirm:$false
#optional add more hdd
Get-VM $vmname | New-HardDisk -CapacityGB <#size in gb#> -Persistence persistent
#turn on VM
Start-VM -VM $vm -Confirm:$false
