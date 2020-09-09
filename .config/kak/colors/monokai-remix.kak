## An attempt to port monokai to kakoune
## ported by raimu
## Credits :
## Based on the monokai palette from Cocadaimon on terminal.sexy

evaluate-commands %sh{

    fgwhite='rgb:f1ebeb'
		white='rgb:acada1'
		dimwhite='rgb:cfd0c2'
		bgblack='rgb:272822'
		darkblack='rgb:211f1c'
		black='rgb:48483e'
		lightblack='rgb:76715e'
		darkgrey='rgb:64645e'
		warmgrey='rgb:75715e'
		grey='rgb:8f908a'
		pink='rgb:fa2772'
		dimpink='rgb:dc2566'
		green='rgb:a7e22e'
		dimgreen='rgb:8fc029'
		yellow='rgb:e7db75'
		dimyellow='rgb:d4c96e'
		blue='rgb:819aff'
		dimblue='rgb:6a7ec8'
		purple='rgb:ae82ff'
		dimpurple='rgb:8c6bc8'
		aqua='rgb:66d9ee'
		dimaqua='rgb:55bcce'
		orange='rgb:fd9720'
		dimorange='rgb:cc7720'
    red='rgb:e73c50'

		## code
    echo "
        face global value ${purple}
        face global type ${aqua}+i
        face global identifier ${orange}
        face global variable ${fgwhite}
        face global module ${yellow}
        face global function ${green} 
        face global string ${yellow}
        face global keyword ${pink}+b
        face global operator ${dimpink}
        face global attribute ${dimgreen}
        face global comment ${warmgrey}
        face global documentation ${grey}
        face global meta ${pink}
        face global builtin ${blue}+b
    "

    ## markup
    echo "
        face global title ${green}+b
        face global header ${dimgreen}+b
        face global bold ${cyan}+b
        face global italic ${cyan}+i
        face global underline default,${blue}+ufa
        face global strikethrough default+bfg
        face global mono ${yellow}
        face global block ${aqua}
        face global link ${purple}+u
        face global bullet ${dimgreen}
        face global list ${dimgreen}
    "

    ## builtin
    echo "
        face global Default ${fgwhite},${bgblack}
        face global PrimarySelection ${black},${fgwhite}+bfg
        face global SecondarySelection ${black},${fgwhite}+fg
        face global PrimaryCursor ${bgblack},${pink}+bfg
        face global SecondaryCursor ${bgblack},${blue}+fg
        face global PrimaryCursorEol ${bgblack},${purple}+bfg
        face global SecondaryCursorEol ${bgblack},${purple}+fg
        face global LineNumbers ${darkgrey},${bgblack}
        face global LineNumberCursor ${dimgreen},${bgblack}
        face global MenuForeground ${dimblue}
        face global MenuBackground default,${darkblack}
        face global MenuInfo ${orange}+i
        face global Information ${green}
        face global Error ${bgblack},${pink}+fg
        face global StatusLine ${dimaqua},${darkblack}
        face global StatusLineMode ${dimaqua}
        face global StatusLineInfo ${dimaqua}
        face global StatusLineValue ${aqua}
        face global StatusCursor ${bgblack},${white}+bg
        face global Prompt ${purple},${darkblack}
        face global MatchingChar default,${red}+b
        face global BufferPadding ${warmgrey},${darkblack}
        face global Whitespace ${warmgrey}+f
    "

}
