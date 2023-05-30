# datetime
date_and_week=$(date +'%Y-%m-%d %I:%M:%S %p')

# volume
if [ $(amixer sget Master | awk '/Left:/ { print $6 }') = "[off]" ]; then
    volume_text="🔇"
else
    volume_pct=$(pactl list sinks | grep -C 10 "RUNNING" | grep "Volume:" | awk '{ print $12 }')
    volume_text="🔊 $volume_pct"
fi

# network
network=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
interface_name=$(dmesg | grep $network | grep renamed | awk 'NF>1{print $NF}')
ping=$(ping -c 1 www.google.com | tail -1 | awk '{print $4}' | cut -d '/' -f 2 | cut -d '.' -f 1)
network_text="🖧 $interface_name (${ping}ms)" 

printf "%s | " \
     "$network_text" "$volume_text" "$date_and_week"
