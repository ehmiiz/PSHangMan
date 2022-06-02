function New-HangManGame {
    do {
        try {
            $TheSecret = Import-Csv "$((Get-Location).path)\Secrets.csv" -Delimiter ";"
            $TheSecret = Get-Random $TheSecret
            $Tiles = @()
            $Rules = "Welcome to PSHangMan. Standard hangman rules.`nSelections can only be 1 character.`nIf multiple is entered, the first one will be picked.`nEmpty selections will count as a wrong answer.`nGood luck. Hint: Tech companies."
            for ($i = 0; $i -lt $TheSecret.Names.Length; $i++) {
                $Tiles += "_ "
            }
        }
        catch {
            try {
            Write-Warning "Did not find the CSV, tried looking here: "$((Get-Location).path)\Secrets.csv" ; please retry"
            $PathToRepo = Read-Host "Full path to repo? Ex: 'C:\Users\Emil\PSHangMan'"
            $TheSecret = Import-Csv "$PathToRepo\Secrets.csv" -Delimiter ";"
            } catch {
                "Run it from it's origin path. Like this PS> .\PSHangMan.ps1"
                break;
            }
            
        }

        [int]$MaxStage = 6
        Invoke-HangMan -Stage 0
        Write-Host $Tiles
        Write-Host $Rules -ForegroundColor Green
        [string]$Selection = Read-Host "Please make your first selection"
        if (!$Selection) { [string]$Selection = "0" }
        if ($Selection.length -gt 1) { [string]$Selection = [string]$Selection[0] }
        for ($CurrentStage = 1; $CurrentStage -le $MaxStage; $CurrentStage++) {
            if ($TheSecret.Names -like "*$Selection*") {
                #Correct
                if ($CurrentStage -eq 0) {
                    for ($i = 0; $i -lt $TheSecret.Names.Length; $i++) {
                        if ($TheSecret.Names[$i] -like "*$Selection*") {
                            $Tiles[$i] = $Selection.ToUpper()
                        }
                    }
                    $CurrentStage = 0
                    Invoke-HangMan -Stage $CurrentStage
                    Write-Host $Tiles
                    [string]$Selection = $null
                    [string]$Selection = Read-Host "Correct! Guess again"
                    if (!$Selection) { [string]$Selection = "0" }
                    if ($Selection.length -gt 1) { [string]$Selection = [string]$Selection[0] }
                }
                else {
                    for ($i = 0; $i -lt $TheSecret.Names.Length; $i++) {
                        if ($TheSecret.Names[$i] -like "*$Selection*") {
                            $Tiles[$i] = $Selection.ToUpper()
                        }
                    }
                    if ($Tiles -notcontains "_ " -and $Selection) {
                        $CurrentStage = $CurrentStage - 1
                        Invoke-HangMan -Stage $CurrentStage
                        Write-Host $Tiles; Write-Host "VICTORY!" -ForegroundColor Green
                        Write-Host "Since you WON, heres a good fact about $($thesecret.names): $($TheSecret.GoodFact)" -ForegroundColor Green
                        $TryAgain = Read-Host "Go again y/n?"
                        break
                    }
                    $CurrentStage = $CurrentStage - 1
                    Invoke-HangMan -Stage $CurrentStage
                    Write-Host $Tiles
                    [string]$Selection = $null
                    [string]$Selection = Read-Host "Correct! Guess again"
                    if (!$Selection) { [string]$Selection = "0" }
                    if ($Selection.length -gt 1) { [string]$Selection = [string]$Selection[0] }
                }
            }
            else {
                #Wrong
                if ($MaxStage -le $CurrentStage) {
                    Invoke-HangMan 6
                    Write-Host "Right Answer: $($TheSecret.Names)" -ForegroundColor Green
                    Write-Host "Since you lost, heres a bad fact about $($thesecret.names): $($TheSecret.BadFact)" -ForegroundColor Red
                    $TryAgain = Read-Host "You loose! Try again. y/n?"
                }
                else {
                    Invoke-HangMan -Stage $CurrentStage
                    Write-Host $Tiles
                    [string]$Selection = $null
                    [string]$Selection = Read-Host "Wrong, guess again"
                    if (!$Selection) { [string]$Selection = "0" }
                    if ($Selection.length -gt 1) { [string]$Selection = [string]$Selection[0] }
                }
            }    
        }
    }
    until ($TryAgain -eq "n")
}