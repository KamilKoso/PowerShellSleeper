Add-Type -Assembly System.Windows.Forms

Write-Host "How much time before putting the computer to sleep?"
$TimeBeforeSleep = New-TimeSpan -Days (Read-Host "Days") -Hours (Read-Host "Hours") -Minutes (Read-Host "Minutes") -Seconds (Read-Host "Seconds");
$TimerStart = [datetime]::UtcNow;
$EndTime = $TimerStart.Add($TimeBeforeSleep);
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


