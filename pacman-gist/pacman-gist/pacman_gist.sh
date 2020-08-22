#!/bin/sh

#if [[ $- == *i* ]]; then
normal="$(tput sgr0)"
bold="$(tput bold)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"
#fi

# PACMANFILE="$(hostname).pacman-list.pkg"
# AURFILE="$(hostname).aur-list.pkg"
PACMANFILE="/tmp/$(hostname).pacman-list.pkg"
AURFILE="/tmp/$(hostname).aur-list.pkg"
GIST_IDS=~/.config/pacman-gist/gist-ids.list

TMP_NAT_LIST=/tmp/pacman.list
TMP_AUR_LIST=/tmp/aur.list
TMP_NAT_GIST=/tmp/pacman.gist
TMP_AUR_GIST=/tmp/aur.gist

create_package_lists() {
    pacman -Qqen > $PACMANFILE
    pacman -Qqem > $AURFILE
}

create_gist() {
	echo "${bold}${green}==>${white} Saving installed package lists to gists..."
    echo "${bold}${cyan}  ->${white} Creating packages lists..."
    echo "${bold}${cyan}  ->${white} Generating gist links..."

    create_package_lists

    GIST_NAT=$(pacman -Qqen | \
        gist create "$(hostname): Pacman package list." --filename $PACMANFILE)
    GIST_AUR=$(pacman -Qqem | \
        gist create "$(hostname): AUR package list." --filename $AURFILE)

    echo "GIST_NAT=${GIST_NAT}" | \
        sed 's/https:\/\/gist.github.com\///g' > $GIST_IDS;
    echo "GIST_AUR=${GIST_AUR}" | \
        sed 's/https:\/\/gist.github.com\///g' >> $GIST_IDS;

    echo "    [ ${cyan}${GIST_NAT}${white} ]"
    echo "    [ ${cyan}${GIST_AUR}${white} ]"

}
update_gist() {
    echo "${bold}${cyan}::${white} Processing gists update...${normal}"

    GIST_NAT=$(grep -oP '(?<=GIST_NAT=).*' $GIST_IDS)
    GIST_AUR=$(grep -oP '(?<=GIST_AUR=).*' $GIST_IDS)

    # Exit if gists are empty/do not exist
    [[ -z $GIST_NAT && -z $GIST_AUR ]] && exit 1

    # Create temporary files of currently uploaded gists
    gist content $GIST_NAT | tail -n +2 | head  > /tmp/pacman.gist
    gist content $GIST_AUR | tail -n +2 | head  > /tmp/aur.gist

    if ! diff /tmp/pacman.gist /tmp/pacman.list > /dev/null 2>&1; then
        # är annorlunda



        echo "GIST_NAT=${GIST_NAT}" | \
            sed 's/https:\/\/gist.github.com\///g' > $GIST_IDS;
    fi

#    echo "GIST_AUR=${GIST_AUR}" | \
#        sed 's/https:\/\/gist.github.com\///g' >> $GIST_IDS;


    diff /tmp/aur.gist /tmp/aur.list > /dev/null 2>&1

    echo $GIST_NAT
    echo $GIST_AUR

# cmp compare skillnad mellan github gist och lokal fil

}

pacman_gist() {
    # Check for gist token
    if ! test -s ~/.config/gist; then
        echo "${bold}${red}::${white}~/.config/gist: token file not found.${normal}"
        exit 1
    fi

    # Check if pacman gist ids exist locally
	if test -s $GIST_IDS; then
		update_gist
	else
		create_gist
	fi
}

pacman_gist


# cat fil | sed 's/(sak att byta)//g'

# conda install -c conda-forge python-gist