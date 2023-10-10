#!/bin/bash
dpkg -l | sed '1,5d' | while read -r line; do
    #package_name=$(echo "$line" | awk '{print $0}')
    #echo "$package_name"
    #awk '{print $1}' <<< "${line}"
    count=0
    IFS=' ' read -ra words <<<"$line"
    for word in "${words[@]}"; do
        ((count++))
        if [ $count -eq 2 ]; then
            echo -e "======================================================================\npackage_name:${word}\nrelated files:"
            dpkg -L "${word}"
        elif [ $count -eq 3 ]; then
            echo -e "version:$word"
            break
        fi
    done
done
echo "======================================pci info:"
lspci
echo "======================================usb info:"
lsusb
#dpkg -l | awk 'NR > 5 {
#    print $2
#}'
