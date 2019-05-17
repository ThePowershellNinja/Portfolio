#https://theitbros.com/change-local-and-active-directory-user-password-using-powershell/

$Computers = 'Computer1','Computer2','localhost'
$Password = 'NewPassword1'
$Account = 'Guest'
foreach ($computer in $Computers) {
    
    try {

        [adsi]$User = "WinNT://$computer/$Account,user"
        $User.SetPassword($Password)
        Write-Output "Successfully set password for the $Account account on Computer: $computer"
    }
    catch {

        Write-Error "Failed to change the password for the $Account account on computer: $Computer"
    }
}
