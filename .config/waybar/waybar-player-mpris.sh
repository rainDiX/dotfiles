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
      tooltip="$tooltip$player : $_text"
      ;;
    Paused )
      _text=" $(playerctl --player=$player metadata title) - $(playerctl --player=$player metadata artist)"
      text="$text\n$_text"
      tooltip="$tooltip$player : $_text"
      ;;
    Stopped )
      _text=""
      tooltip="$tooltip$player : $_text\n"
      ;;
  esac
done

# Remove the last new line & insert a \ before the quote character if present
text=$(echo "$text" | tail -1 | sed 's|"|\\"|g')
tooltip=$(echo $tooltip | sed 's|"|\\"|g')
if [ -n "$text" ]; then
  echo '{"text": "'$text'", "tooltip": "'$tooltip'" }'
fi
