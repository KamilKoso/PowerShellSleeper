Add-Type -Assembly System.Windows.Forms
$host.privatedata.ProgressBackgroundColor = "black";

$TimerStart = [datetime]::UtcNow;
$EndTime = [datetime]::UtcNow
Write-Host "How much time before putting the computer to sleep?"
$EndTime = $EndTime.AddDays([int](Read-Host "Days"))
$EndTime = $EndTime.AddHours([int](Read-Host "Hours"))
$EndTime = $EndTime.AddMinutes([int](Read-Host "Minutes"))
$EndTime = $EndTime.AddSeconds([int](Read-Host "Seconds"))

while (($TimeRemaining = ($EndTime - [datetime]::UtcNow)) -gt 0) {
    $TimeRemainingString = "";
    if ($TimeRemaining.Days -gt 0) {
        $TimeRemainingString += $TimeRemaining.Days.ToString() + "days "
    }
    if ($TimeRemaining.Hours -gt 0) {
        $TimeRemainingString += $TimeRemaining.Hours.ToString() + "h "
    }
    if ($TimeRemaining.Minutes -gt 0) {
        $TimeRemainingString += $TimeRemaining.Minutes.ToString() + "min "
    }
    if ($TimeRemaining.Seconds -gt 0) {
        $TimeRemainingString += $TimeRemaining.Seconds.ToString() + "s"
    }
    
    $TimePassed = [datetime]::UtcNow - $TimerStart;
    Write-Progress -Activity "Press CTRL + C if you want to stop the timer"  -Status $TimeRemainingString -PercentComplete ($TimePassed.Ticks / ($EndTime.Ticks - $TimerStart.Ticks) * 100);
    Start-Sleep 1;
}

Write-Host "Goodnight :)"
powercfg -hibernate off # otherwise computer might hibernate and funcions such as Wake-On-USB won't work
[System.Windows.Forms.Application]::SetSuspendState("Suspend", $false, $true)


