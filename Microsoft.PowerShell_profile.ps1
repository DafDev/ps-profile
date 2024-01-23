# Imports the terminal Icons into curernt Instance of PowerShell
Import-Module -Name Terminal-Icons 

# Initialize Oh My Posh with the theme which we chose
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\atomic.omp.json" | Invoke-Expression

# Set some useful Alias to shorten typing and save some key stroke
Set-Alias vim nvim 
Set-Alias ll ls 
Set-Alias g git 
Set-Alias grep findstr

# Set Some Option for PSReadLine to show the history of our typed commands
Set-PSReadLineOption -PredictionSource History 
Set-PSReadLineOption -PredictionViewStyle ListView 
Set-PSReadLineOption -EditMode Windows 

#Fzf (Import the fuzzy finder and set a shortcut key to begin searching)
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Utility Command that tells you where the absolute path of commandlets are 
function which ($command) { 
    Get-Command -Name $command -ErrorAction SilentlyContinue | 
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue 
} 

# Utility command to force shutdown the computer
function gts () { 
    shutdown  -s -f -t 0 
} 

# Utility command to force reboot the computer
function reboot () { 
    shutdown  -r -f -t 0 
} 

#Utility command to get git graph
function gitgraph () {
    git fetch;
    git log --graph --oneline --full-history --all
}

#Utility command to git checkout
function gitcheck ($branch) {
    git checkout $branch;
    git pull;
}

Function Tail-Thread {
    Param($file, $linecount, $fileNameColor)
    $grey = $PSStyle.Foreground.FromRgb(160,160,160);
    $blue = $PSStyle.Foreground.FromRgb(144,204,244);
    $yellow = $PSStyle.Foreground.FromRgb(246,255,0);
    $red = $PSStyle.Foreground.FromRgb(225,23,0);
    $infoKeyword = "INFO";
    $debugKeyword = "DEBUG";
    $warningKeyword = "WARNING";
    $errorKeyword = "ERROR";

    Get-Content -Path $file.FullName -Tail $linecount -Wait | 
    ForEach-Object {  
        switch -Regex ($_)
        {
            $infoKeyword {Write-Output "`n$($fileNameColor)$($file.Name)`n------------------`n$($PSStyle.Reset)$($grey)${_}$($PSStyle.Reset)"}
            $debugKeyword {Write-Output "`n$($fileNameColor)$($file.Name)`n------------------`n$($PSStyle.Reset)$($blue)${_}$($PSStyle.Reset)"}
            $warningKeyword {Write-Output "`n$($fileNameColor)$($file.Name)`n------------------`n$($PSStyle.Reset)$($yellow)${_}$($PSStyle.Reset)"}
            $errorKeyword {Write-Output "`n$($fileNameColor)$($file.Name)`n------------------`n$($PSStyle.Reset)$($red)${_}$($PSStyle.Reset)"}
            default {Write-Output "`n$($fileNameColor)$($file.Name)`n------------------`n$($PSStyle.Reset)${_}"}
        }
    } 
}


# Get the function's definition *as a string*
$funcDef = ${function:Tail-Thread}.ToString()

#second utility to tail logs
Function Tail ($path="C:\Temp\Explore\log", $filter="*.log", $linecount=10) {
    Get-ChildItem -Path $path  -Filter $filter | 
    ForEach-Object -Parallel { 
        $fileNameColor = $PSStyle.Foreground.FromRgb(0,200,100);
        $file=$_;
        $numberOfLines = 10;
        ${function:Tail-Thread} = $using:funcDef;
        Tail-Thread $file $numberOfLines $fileNameColor;
    }
}