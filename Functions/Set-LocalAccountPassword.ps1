<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>

function Set-LocalAccountPassword {

    [CmdletBinding()]

    param (

        [Parameter(ValueFromPipeline = $true,ValueFromPipelineByPropertyName = $true, Mandatory = $true)]
        [string[]]$ComputerName,

        [Parameter(Mandatory = $true)]
        [string]$Password,

        [string]$Account = 'Administrator'
    )

    begin {
        Write-Output 'This is my Begin'
        $Account = 'Administrator'
    }

    process {

        Write-Output "This is my Process"
        #https://theitbros.com/change-local-and-active-directory-user-password-using-powershell/

        foreach ($computer in $ComputerName) {
    
            try {

                [adsi]$User = "WinNT://$computer/$Account,user"
                $User.SetPassword($Password)
                Write-Output "Successfully set password for the $Account account on Computer: $computer"
            }
            catch {

                Write-Error "Failed to change the password for the $Account account on computer: $Computer"
            }
        }
    }

    end {
        Write-Output 'This is my End'
    }
}