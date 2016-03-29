# Custom prompt based on eclm prompt with inspiration from agnoster.

function _git_branch_name
    echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
    echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

# http://stackoverflow.com/questions/866989/fish-interactive-shell-full-path
function _long_pwd
    if test "$PWD" != "$HOME"
        echo (echo $PWD | sed -e 's|/private||' -e "s|^$HOME|~|")
    else
        echo '~'
    end
end

function fish_prompt
    set -l last_status $status
    set -l yellow (set_color yellow)
    set -l red (set_color red)
    set -l green (set_color green)
    set -l magenta (set_color magenta)
    set -l normal (set_color normal)

    if test (jobs -l | wc -l) -gt 0
        set arrow "$green⚙ "
    else
        set arrow ""
    end

    if test $last_status -gt 0
        set arrow "$arrow$red✗ "
    end

    set -l cwd $magenta(_long_pwd)

    if [ (_git_branch_name) ]
        set -l git_branch (_git_branch_name)

        if [ (_is_git_dirty) ]
            set -l dirty "$red ±"
            set git_info "$yellow git:$yellow$git_branch$dirty$yellow"
        else
            set git_info "$green git:$green$git_branch$green"
        end
    end

    echo -n -s $arrow $cwd $git_info $normal ' • '
end

