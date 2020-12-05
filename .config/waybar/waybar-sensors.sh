#!/bin/sh

#waybar json
text=''
tooltip=''
percentage='0'

coretemp='null'
dell_smm='null'

for mon in /sys/class/hwmon/*
do
  if [ "$(cat "$mon"/name)" = 'coretemp' ];then
    coretemp="$mon"
  elif [ "$(cat "$mon"/name)" = 'dell_smm' ];then
    dell_smm="$mon"
  fi
done

if [ "$dell_smm" != 'null' ]; then
  name='Fan'
  rpm=$(cat "$dell_smm"/fan1_input)
  tooltip="$tooltip$name\\\\t\\\\t$rpm RPM\\\\n"
fi

if [ "$coretemp" != 'null' ]; then
  sensor_cout="$(find "$coretemp"/temp*_label | xargs basename -a | sed 's/[^0-9]//g')"
  for i in $sensor_cout
  do
     name=$(cat "$coretemp"/temp"$i"_label)
     temp=$(echo "$(cat "$coretemp"/temp"$i"_input)/1000" | bc)
     if [ "$name" = 'Package id 0' ]; then
       text="$temp°C"
       # on most CPUs the max temp is 100°C
       percentage=$temp 
       tooltip="$tooltip$name\\\\t$temp°C\\\\n"
     else
       tooltip="$tooltip$name\\\\t\\\\t$temp°C\\\\n"
     fi
  done
fi

# remove the last useless \n
tooltip=${tooltip%???}

echo '{"text": "'$text'", "tooltip": "'$tooltip'", "percentage": '$percentage' }'
