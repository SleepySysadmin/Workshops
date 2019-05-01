
param (
    [Parameter(mandatory=$true,
    HelpMessage="pls")]
    [string[]]$ComputerName


)
Begin
{


}

Process 
{
        
    Foreach ($Computer in $ComputerName)
    {

            try 
            { 

                $Computersystem = Get-CimInstance -ComputerName $Computer -ClassName win32_computersystem -ErrorAction Stop
                $OperatingSystem = Get-CimInstance -ComputerName $Computer -ClassName win32_operatingsystem

                $Properties = @{
                    Model = $Computersystem.Model
                    Status = "Online"
                    Username = $Computersystem.UserName
                    man = $Computersystem.Manufacturer
                    Serial = $OperatingSystem.SerialNumber
                    Version = $OperatingSystem.Version
                }

                $Output = New-Object -TypeName psobject -Property $Properties

            }
            Catch
            {

                $Properties = @{
                    Model = $Computersystem.Model
                    Status = "Offline"
                    Username = $Computersystem.UserName
                    man = $Computersystem.Manufacturer
                    Serial = $OperatingSystem.SerialNumber
                    Version = $OperatingSystem.Version

                }
                
                $Output = New-Object -TypeName psobject -Property $Properties

            }
            Finally
            {

                Write-output $Output

            }

    }
}

End
{


}
