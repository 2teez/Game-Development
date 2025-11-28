filename="${1}"

if [[ -z "${filename}" ]]; then
    echo "Specify filename!"
    exit 1
fi

g++ "${filename}" -o app \
    -I/opt/homebrew/include \
    -L/opt/homebrew/lib \
    -Wl,-rpath,/opt/homebrew/lib \
    -lsfml-graphics -lsfml-window -lsfml-system \
    -std=c++17

./app && rm app
