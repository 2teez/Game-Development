#!/usr/bin/env bash
# Date: 27/11/2025
# Author: omitida
# Description: Generate and compile c++
# game files using SFML and other libraries
#

# get helper prompt
function helper_prompt() {
    echo "${0} <option> <filename>"

    echo "Avaliable options:"
    echo "-g    : Create generic SFML file"
    echo "-h    : Get this helper prompt"
}

function write_SFML_file() {
    filename="${1}"
    echo "#include <SFML/Graphics.hpp>" > "${filename}"
    echo >> "${filename}"
    echo "int main(int argc, char* argv[])
{

    return 0;
}" >> "${filename}"
}

# get a filename
function get_game_file() {
    filename="${1}"
    file_extension="${filename#*.}"
    # check the file extension and
    # change it to cpp if not cpp
    if [[ "${file_extension}" != "cpp" ]]; then
        filename="${filename%.*}.cpp"
        if [[ -e "${filename}" ]]; then
            while read -p "Do you want to overwrite ${filename}? [Yn]: " ans; do
                case "${ans,,}" in
                    y)
                        write_SFML_file "${filename}"
                        break
                        ;;
                    n)
                        echo "File ${filename} exit and you decided not to overwrite it."
                        break
                        ;;
                    *)
                        echo "Use only Y or N."
                        ;;
                esac
            done
        fi
    fi

}

[[ "${#}" != 2 ]] && helper_prompt

opstring="d:g:r:h"

while getopts "${opstring}" opt; do
    case "${opt}" in
        d)
            filename="${OPTARG}"
            echo "Deleting ${filename}..."
            if [[ -d "${filename}" ]]; then
                rm -rf "${filename}"
                exit;
            fi
            rm "${filename}" # delete a file
            ;;
        g)
            filename="${OPTARG}"
            get_game_file "${filename}"
            ;;

        r)
            filename="${OPTARG}"
            g++ "${filename}" -o app \
                -I/opt/homebrew/include \
                -L/opt/homebrew/lib \
                -Wl,-rpath,/opt/homebrew/lib \
                -lsfml-graphics -lsfml-window -lsfml-system \
                -std=c++17

            ./app && rm app
            ;;
        *)
            echo "Invalid option."
            helper_prompt
            ;;
    esac
done
