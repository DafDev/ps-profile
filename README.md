# ps-profile
Just a realy pretty, imho, powershell profile 

## Install scoop

Inside a Powesrshell terminal type
```bash 
iwr -useb get.scoop.sh | iex 
```
## Install other modules 

First install curl (the client url tools), sudo (adds the concept to sudo to PowerShell), jq using scoop:

    scoop install curl sudo jq jid   
Then install neovim:

    scoop install neovim gcc 

Install "z" module with the *Install-Module* function

    Install-Module -Name z –Force 

So, imagine every time we need to go to:
*C:\Users\Daf\source\repos*, We need to type:
cd *C:\Users\Daf\source\repos*. But if we only visit this directory once, we can simply navigate to it using, z repos, easy as that, it saves a lot of keystrokes!

Install terminal Icons (It gives specific Icons to windows based on file type)
```bash
Install-Module -Name Terminal-Icons -Repository PSGallery
Install PSReadLine (add autocompletion to PowerShell based on previous commands)
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
Install Fzf (Fuzzy finder and its PowerShell Module)
scoop install fzf
Install-Module -Name PSFzf -Scope CurrentUser -Force
```

## Install oh my posh 

We can finally install oh my posh which will beautify our prompt:
```bash
scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
```

### Install the nerd font

Go to the [nerd font github](https://github.com/ryanoasis/nerd-fonts) repo 
