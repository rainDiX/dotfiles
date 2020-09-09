#
## Based on Tomorrow-night, adapted by nicholastmosher
## edited with Tomorrow-night-Bright colors
## Additional darkgrey color for whitespace
##

evaluate-commands %sh{
    foreground="rgb:eaeaea" # gui05
    background="rgb:1d1f21" # gui00
    selection="rgb:424242"  # gui02
    window="rgb:2a2a2a"     # gui01
    comment="rgb:969896"    # gui03
    red="rgb:d54e53"        # gui08
    orange="rgb:e78c45"     # gui09
    yellow="rgb:e7c547"     # gui0A
    green="rgb:b9ca4a"      # gui0B
    blue="rgb:7aa6da"       # gui0D
    aqua="rgb:70c0b1"       # gui0C
    purple="rgb:c397d8"     # gui0E
    darkgrey="rgb:5a5b5a"   # not originally in Tomorrow

    ## code
    echo "
        face global value ${orange}
        face global type ${yellow}
        face global variable ${red}
        face global module ${blue}
        face global function ${blue}
        face global string ${green}
        face global keyword ${purple}
        face global operator ${aqua}
        face global attribute ${purple}
        face global comment ${comment}
        face global documentation comment
        face global meta ${purple}
        face global builtin ${yellow}
    "

    ## markup
    echo "
        face global title ${blue}
        face global header ${aqua}
        face global mono ${green}
        face global block ${orange}
        face global link ${blue}
        face global bullet ${red}
        face global list ${red}
    "

    ## builtin
    echo "
        face global Default ${foreground},${background}
        face global PrimarySelection ${foreground},${selection}+fg
        face global SecondarySelection ${foreground},${window}+fg
        face global PrimaryCursor ${background},${foreground}+fg
        face global SecondaryCursor ${background},${aqua}+fg
        face global PrimaryCursorEol ${background},${green}+fg
        face global SecondaryCursorEol ${background},${green}+fg
        face global LineNumbers ${comment},${window}
        face global LineNumberCursor ${yellow},${window}+b
        face global MenuForeground ${window},${foreground}
        face global MenuBackground ${foreground},${window}
        face global MenuInfo ${red}
        face global Information ${foreground},${window}
        face global Error ${foreground},${red}
        face global StatusLine ${foreground},${selection}
        face global StatusLineMode ${yellow}+b
        face global StatusLineInfo ${aqua}
        face global StatusLineValue ${green}
        face global StatusCursor ${window},${aqua}
        face global Prompt ${background},${aqua}
        face global MatchingChar ${yellow},${background}+b
        face global BufferPadding ${aqua},${background}
        face global Whitespace ${darkgrey}+f
    "
}
