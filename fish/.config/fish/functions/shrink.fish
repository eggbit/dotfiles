# Losslessly compresses JPEG and PNG
# argv[1] = safety flag
# argv[2] = filename
function _compress
    set in_file $argv[2]
    set in_file_clean (basename $in_file)
    set size (stat -f%z $in_file)
    set size_kb (expr $size / 1000 + 1)KB
    set extension (echo $in_file | awk -F . '{print $NF}')

    if test $argv[1] -eq 1
        set out_file (echo $in_file | sed 's/\.[^.]*$//')_opt.$extension
    else
        set out_file $in_file
    end

    switch $extension;
        case "jpg"
            jpegtran -copy none -progressive -optimize -outfile $out_file $in_file
        case "png"
            optipng -o5 -strip all -silent -nc -nb -out $out_file $in_file
            # advdef -z -4 $out_file
    end

    set new_size (stat -f%z $out_file)
    set new_size_kb (expr $new_size / 1000 + 1)KB
    set ret_bytes (expr $size - $new_size)

    echo "Compressed $in_file_clean: $size_kb -> $new_size_kb"
end

function shrink
    # Check for no arguments or 3+.
    if begin; not count $argv > /dev/null; or test (count $argv) -ge 3; end
        echo "Usage: shrink path [--safe]"
        return
    end

    # Check for required programs.
    type -q jpegtran; and type -q optipng; and type -q parallel

    if test $status -gt 0
        echo "Error: Check that jpegtran, optipng, and gnu parallel are installed."
        echo "brew install libjpeg optipng parallel"
        return
    end

    # Contains return 0 on true so the status needs to be flipped.
    set -l safety_flag (not contains -- --safe $argv) $status

    # Check if path passed is a file or directory
    if test -f $argv[1]
        _compress $safety_flag $argv[1]
    else if test -d $argv[1]
        find $argv[1] -name "*.png" -o -name "*.jpg" -type f | sed "s,//,/,g" | parallel -j+0 _compress {} $safety_flag
    end

    return 0
end
