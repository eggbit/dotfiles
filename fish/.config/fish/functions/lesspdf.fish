function lesspdf --description 'Compresses PDFs.  Must have pdf2ps and ps2pdf installed.'
    switch (count $argv);
        case 1
            set output $argv[1]
        case 2
            set output $argv[2]
        case '*'
            echo "Usage: lesspdf input.pdf [output.pdf]"
            return 1
    end

    pdf2ps $argv[1] temp.ps
    ps2pdf temp.ps $output

    rm temp.ps
end
