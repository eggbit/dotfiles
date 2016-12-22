### Environment Variables ###
set -x EDITOR nano
set -x CLICOLOR 1
set -x TERM xterm-256color

### Paths ###
set -l paths /usr/local/sbin \
             /sbin \
             /Applications/MAMP/bin/php/php5.6.10/bin \
             /Applications/MAMP/Library/bin/

for e in $paths
    if test -d $e
        set PATH $PATH $e
    end
end

### Aliases ###
alias optipng       "optipng -o5 -strip all"
alias ls            "ls -lahFG"
alias scripts-edit  "code ~/_scripts"
alias dots-edit     "code ~/_dotfiles"
alias bt            "aria2c --file-allocation=none -u 96K --bt-require-crypto=true -d /volumes/universal/downloads/"
