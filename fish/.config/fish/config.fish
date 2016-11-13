### Environment Variables ###
set -x EDITOR nano

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
alias tearoot="cd ~/sites/clients/tea"
alias optipng="optipng -o5 -strip all"
alias ls="ls -lahFG"
