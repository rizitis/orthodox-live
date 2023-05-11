#!/bin/bash

# Read the URLs from the file specified by the user
get_urls() {
    urls=$(zenity --file-selection --title="Select URLs file" --file-filter="*.txt")
    if [[ -n $urls ]]; then
        url_list=($(cat $urls))
    fi
}

# Play the selected URL with the chosen player
play_url() {
    player=$1
    url=$2
    case $player in
        "mpv")
            mpv $url &
            ;;
        "vlc")
            vlc $url &
            ;;
        "totem")
            totem $url &
            ;;
        "mplayer")
            mplayer $url &
            ;;
    esac
}

# Build the GUI using Zenity
get_urls
if [[ -n ${url_list[@]} ]]; then
    selected_url=$(zenity --list --title="Select a station" --column="Station URL" "${url_list[@]}")
    if [[ -n $selected_url ]]; then
        selected_player=$(zenity --list --title="Select a player" --column="Player" "mpv" "vlc" "totem" "mplayer")
        if [[ -n $selected_player ]]; then
            play_url $selected_player $selected_url
        fi
    fi
fi

