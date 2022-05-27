# Place this file in {User}/Documents/WindowsPowerShell/

# Must run Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Fix bug where ctrl+backspace prints "^W" to the console in vscode
if ($env:TERM_PROGRAM -eq "vscode") {
  Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardKillWord
}

# Aliases
Set-Alias -Name ipy -Value ~\AppData\Local\Programs\Python\Python39\Scripts\ipython.exe
Set-Alias -Name venv -Value .\venv\Scripts\activate

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.fu 'commit -m'
git config --global alias.st status
git config --global alias.last 'log -1 HEAD'
git config --global alias.undo 'reset --soft HEAD^'

function st() {
    git status
}

function co() {
    git checkout $args
}

function penv() {
    poetry shell
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
