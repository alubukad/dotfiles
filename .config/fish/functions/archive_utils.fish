function extract_archive
    switch $argv[1]
        case '*.tar.bz2'
            tar xvjf $argv[1]
        case '*.tar.gz'
            tar xvzf $argv[1]
        case '*.zip'
            unzip $argv[1]
        case '*.rar'
            unrar x $argv[1]
        case '*'
            echo "Don't know how to extract $argv[1]"
    end
end
