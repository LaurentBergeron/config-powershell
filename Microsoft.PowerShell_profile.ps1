# Place this file in {User}/Documents/WindowsPowerShell/

# Must run Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Fix bug where ctrl+backspace prints "^W" to the console in vscode
if ($env:TERM_PROGRAM -eq "vscode") {
  Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardKillWord
}

function prompt {
    'PS ' + $(Get-Location) +
        $(if ($NestedPromptLevel -ge 1) { '>>' }) +
        "`r`n> "
}

# Aliases
Set-Alias -Name ipy -Value ~\AppData\Local\Programs\Python\Python39\Scripts\ipython.exe
Set-Alias -Name venv -Value .\venv\Scripts\activate
Set-Alias -Name deac -Value deactivate
Set-Alias -Name m -Value mypy
Set-Alias -Name f -Value flake8
Set-Alias -Name t -Value pytest

# Must run `PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force`
Import-module posh-git

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.fu 'commit -m'
git config --global alias.st status
git config --global alias.last 'log -1 HEAD'
git config --global alias.undo 'reset --soft HEAD^'
git config --global alias.wip 'commit -m "wip"'
git config --global push.default current

function v() {
    poetry shell
}

function lock() {
    poetry lock --no-update
    poetry install --all-extras
}

function st() {
    git status
}

function gp() {
    git push
}

function co() {
    git checkout $args
}

function wip() {
    git add .
    git commit -m "wip"
}

function sync() {
    git checkout main
    git pull
    git checkout -
}
function release() {
    If($args.Length -ne 1) {
        echo "usage: release 0.1.0"
        Return
    }
    echo "Tagging and pushing version $args!"
    git tag -a v$args -m "Release Version v$args"
    git push origin v$args
}

# unit tests
function tu() {
    pytest tests
}