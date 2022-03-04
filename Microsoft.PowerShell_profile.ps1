# Place this file in {User}/Documents/WindowsPowerShell/

# Fix bug where ctrl+backspace prints "^W" to the console in vscode
if ($env:TERM_PROGRAM -eq "vscode") {
  Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardKillWord
}

# Aliases
Set-Alias -Name ipy -Value C:\Users\LaurentBergeron\AppData\Local\Programs\Python\Python39\Scripts\ipython.exe
Set-Alias -Name ipy37 -Value C:\Users\LaurentBergeron\AppData\Local\Programs\Python\Python37\Scripts\ipython.exe
Set-Alias -Name venv -Value .\venv\Scripts\activate

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.fu 'commit -m'
git config --global alias.st status
git config --global alias.last 'log -1 HEAD'

function st() {
    git status
}

function co() {
    git checkout $args
}

function gp() {
    git push
}

function penv() {
    poetry shell
}
