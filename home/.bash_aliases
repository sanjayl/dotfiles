alias d='l'
alias s='cd ..'
alias ss='cd ../..'
alias sss='cd ../../..'
alias lh='ls -lh'
alias lhs='ls -lhS'
alias lhS='ls -lhSr'
alias launch='xdg-open'
alias open='xdg-open'
alias tt='toggle_transparency'
alias trim='sudo fstrim -v /'

#FUNCTIONS
toggle_transparency() {
    BACKGR=`gconftool -g /apps/gnome-terminal/profiles/Default/background_type`

    case "$BACKGR" in
	solid )
	    gconftool -s -t string /apps/gnome-terminal/profiles/Default/background_type transparent ;;
	transparent )
	    gconftool -s -t string /apps/gnome-terminal/profiles/Default/background_type solid ;;
    esac
}
