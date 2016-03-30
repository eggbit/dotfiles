function fish_greeting
    set -l blue (set_color blue)
    set -l green (set_color green)
    set -l normal (set_color normal)
    set -l magenta (set_color magenta)

    # set -l date (date +"%A, %B %d, %Y")
    # set -l time (date +"%r")
    # set -l name (whoami)
    set -l ext_ip (wget http://ipecho.net/plain -qO -)
    set -l int_ip (ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}')

    set -l date (date "+%A %d %B %Y")

    echo $blue$date
    echo
    echo $magenta"Ext. IP: $green$ext_ip"
    echo $magenta"Int. IP: $green$int_ip"
    echo
end
