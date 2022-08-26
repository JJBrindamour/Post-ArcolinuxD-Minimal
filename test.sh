for custom in ./.config/*; do
    for preinstalled in "$HOME"/.config/*; do
        if [[ $(basename $custom) == $(basename $preinstalled)  ]]; then echo $preinstalled; fi
    done
done
