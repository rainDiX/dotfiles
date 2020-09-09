#!/bin/sh
text=''
tooltip=''
players=$(playerctl -l)

for player in $players
do
  status=$(playerctl --player=$player status 2> /dev/null)
  case $status in
    Playing )
      _text=" $(playerctl --player=$player metadata title) - $(playerctl --player=$player metadata artist)"
      text="$text\n$_text"
      tooltip="$tooltip$player : $_text\n"
      ;;
    Paused )
      _text=" $(playerctl --player=$player metadata title) - $(playerctl --player=$player metadata artist)"
      text="$text\n$_text"
      tooltip="$tooltip$player : $_text\n"
      ;;
    Stopped )
      _text=""
      tooltip="$tooltip$player : $_text\n"
      ;;
  esac
done

#text=$(echo -e "$text" | tail -1 | tr -d "'")
#tooltip=$(echo "$tooltip" | tr -d "'")
text=$(echo -e "$text" | tail -1)
if [ -n "$text" ]; then
  echo '{"text": "'$text'", "tooltip": "'$tooltip'" }'
else
  echo ''
fi
