function fish_greeting
    set -l blue (set_color blue)
    set -l green (set_color green)
    set -l normal (set_color normal)
    set -l magenta (set_color magenta)

    # set -l date (date +"%A, %B %d, %Y")
    # set -l time (date +"%r")
    # set -l name (whoami)
    set -l ext_ip (dig +short myip.opendns.com @resolver1.opendns.com)
    set -l int_ip (ipconfig getifaddr en0)
    set -l date (date "+%A %d %B %Y")

    echo $blue$date
    echo
    echo $magenta"Ext. IP: $green$ext_ip"
    echo $magenta"Int. IP: $green$int_ip"
    echo
end
