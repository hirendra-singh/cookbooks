
$Cloud = (Get-ItemProperty -Path HKLM:\Software\LANSA  -Name 'Cloud').Cloud
if (  $Cloud -eq "AWS") {

    #Check if service Amazon SSM Agent is running or not
    Try {

        $SSMService = Get-Service -Name "Amazon SSM Agent" -ErrorAction SilentlyContinue
        if ( $SSMService.Status -eq "Running" ) {
            Write-Host "Amazon SSM Agent is running"
        } else {
            Throw
        }
    } Catch {

        cmd /c exit 1 #Set $LASTEXITCODE
        throw "Amazon SSM Agent is not running"
    }
} elseif ( $Cloud -eq "" ) {

    cmd /c exit 1 #Set $LASTEXITCODE
    Throw "Cloud registry entry is empty"
    
}