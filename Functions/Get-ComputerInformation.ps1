function Get-ComputerInformation {

    Param (

        [String[]]$ComputerName = [system.net.dns]::GetHostEntry('').Hostname,

        [PSCredential]$Credential
    )

    $ComputerName | Foreach-Object {
        
        if ($Credential -ne $false) {
            $Session = New-PSSession -ComputerName $_ -Credential $Credential
        }
        else {
            $Session = New-PSSession -ComputerName $_
        }

        $Processes = Invoke-Command -Session $Session -ScriptBlock { Get-CimInstance -ClassName Cim_process -Filter 'Name = "Powershell.exe" OR Name = "Powershell_ISE.exe"'}
        $Memory    = Invoke-Command -Session $Session -ScriptBlock { Get-CimInstance -ClassName cim_computersystem | Select-Object -ExpandProperty TotalPhysicalMemory}
        $CPU       = Invoke-Command -Session $Session -ScriptBlock { Get-CimInstance -ClassName Cim_Processor}
        $ProcSpeed = $CPU.CurrentClockSpeed
        $ProcCores = $CPU.NumberOfCores

        Remove-PSSession -Session $Session

        [PSCustomObject]@{
            ComputerName           = $_
            PowershellProcessCount = @($Processes).Count
            CPUCoreCount           = $ProcCores
            CPUSpeed               = $ProcSpeed
            PhysicalMemory         = $Memory
        }
    }
}