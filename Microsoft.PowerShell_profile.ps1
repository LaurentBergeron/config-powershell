# Place this file in {User}/Documents/PowerShell/
# Must run Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Fix bug where ctrl+backspace prints "^W" to the console in vscode
if ($env:TERM_PROGRAM -eq "vscode") {
  Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardKillWord
}

# Prompt label
function prompt {
    'PS ' + $(Get-Location) +
        $(if ($NestedPromptLevel -ge 1) { '>>' }) +
        "`r`n> "
}

# Set PSReadling autocomplete options
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

# Aliases
Set-Alias -Name ipy -Value ~\AppData\Local\Programs\Python\Python39\Scripts\ipython.exe
Set-Alias -Name venv -Value .\venv\Scripts\activate
Set-Alias -Name deac -Value deactivate
Set-Alias -Name m -Value mypy
Set-Alias -Name f -Value flake8

git config --global core.longpaths true
git config --global alias.last 'log -1 HEAD'
git config --global alias.undo 'reset --soft HEAD^'
git config --global alias.wip 'commit -m "wip"'
git config --global push.default current

function v() {
    poetry shell
}

function et {
    Invoke-command -ScriptBlock {exit}
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

function br() {
    git branch $args
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

# tests
function t() {
    # run with coverage if there are no arguments to pytest
    If($args.Length -eq 0) {
        pytest --cov
        Return
    }
    pytest $args
}

function trigger() {
    git commit --allow-empty -m"Trigger Build $(Get-Date -UFormat "%FT%T%Z:00")" && git push
}
