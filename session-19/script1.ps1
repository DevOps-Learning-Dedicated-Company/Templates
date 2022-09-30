$RG = "testing"

$A = Get-AzWebApp -ResourceGroupName $RG -Name "host-01"

if ($A.State -eq "Running")
{
    Stop-AzWebApp -ResourceGroupName $RG -Name $A.Name
    Write-Output "WebApp stopped"
}
else 
{
    Start-AzWebApp -ResourceGroupName $RG -Name $A.Name
    Write-Output "WebApp started"
}
