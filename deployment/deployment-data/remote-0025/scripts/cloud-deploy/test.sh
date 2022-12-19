


if [ "$1" = "-i" ]; then
    echo '111'
    shift
    if [ "$1" = "-o" ]; then
        echo '222'
        shift
    fi
    if [ "$1" = "-p" ]; then
        echo '333'
        shift
    fi
fi