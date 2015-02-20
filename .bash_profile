
export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH"

# MacPorts
PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# Python 2.7
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"

# Android SDK
PATH="/Users/bocas/Development/Android/android-sdk-mac/tools:${PATH}"
PATH="/Users/bocas/Development/Android/android-sdk-macosx/platform-tools/:${PATH}"
PATH="/Users/bocas/Development/Android/android-sdk-macosx/tools:${PATH}"

export PATH

# Custom Prompt ------------------------------------------------

default_username='bocas'

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM=xterm-256color
fi

set_prompts() {

    local black="" blue="" bold="" cyan="" green="" orange="" \
          purple="" red="" reset="" white="" yellow=""

    local dateCmd=""

    if [ -x /usr/bin/tput ] && tput setaf 1 &> /dev/null; then

        tput sgr0 # Reset colors

        bold=$(tput bold)
        reset=$(tput sgr0)

        # Solarized colors
        # (https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized#the-values)
        black=$(tput setaf 0)
        blue=$(tput setaf 33)
        cyan=$(tput setaf 37)
        green=$(tput setaf 190)
        orange=$(tput setaf 172)
        purple=$(tput setaf 141)
        red=$(tput setaf 124)
        violet=$(tput setaf 61)
        magenta=$(tput setaf 9)
        white=$(tput setaf 8)
        yellow=$(tput setaf 136)

    else

        bold=""
        reset="\e[0m"

        black="\e[1;30m"
        blue="\e[1;34m"
        cyan="\e[1;36m"
        green="\e[1;32m"
        orange="\e[1;33m"
        purple="\e[1;35m"
        red="\e[1;31m"
        magenta="\e[1;31m"
        violet="\e[1;35m"
        white="\e[1;37m"
        yellow="\e[1;33m"

    fi

    # Only show username/host if not default
    function usernamehost() {
        
        # Highlight the user name when logged in as root.
        if [[ "${USER}" == *"root" ]]; then
            userStyle="${red}";
        else
            userStyle="${magenta}";
        fi;

        userhost=""
        userhost+="\[${userStyle}\]$USER "
        userhost+="${white}at "
        userhost+="${orange}$HOSTNAME "
        userhost+="${white}in"

        # if [ $USER != "$default_username" ]; then echo $userhost ""; fi
        echo $userhost "";
    }

    function prompt_git() {
        # this is 3x faster than mathias's. has to be for working in Chromium & Blink.

        # check if we're in a git repo. (fast)
        git rev-parse --is-inside-work-tree &>/dev/null || return

        # check for what branch we're on. (fast)
        branch=`git symbolic-ref -q --short HEAD`

        # check if it's dirty. (slow)
        #   technique via github.com/sindresorhus/pure
        dirty=$(git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ]&& echo -e "*")

        [ -n "$s" ] && s=" [$s]"
        printf "%s" "$1$branch$2$dirty"

        return
    }



    # ------------------------------------------------------------------
    # | Prompt string                                                  |
    # ------------------------------------------------------------------

    PS1="\[\033]0;\w\007\]"                                 # terminal title (set to the current working directory)
    PS1+="\[$bold\]"
    PS1+="\[$(usernamehost)\]"                              # username at host
    PS1+="\[$green\]\w"                                     # working directory 
    PS1+="\$(prompt_git \"$white on $purple\" \"$cyan\")"   # git repository details
    PS1+="\n"
    PS1+="\[$reset$white\]\\$ \[$reset\]"

    export PS1

    # ------------------------------------------------------------------
    # | Subshell prompt string                                         |
    # ------------------------------------------------------------------

    PS2="⚡ "

    export PS2

    # ------------------------------------------------------------------
    # | Debug prompt string                                            |
    # ------------------------------------------------------------------

    # e.g:
    #
    # The GNU `date` command has the `%N` interpreted sequence while
    # other implementations don't (on OS X `gdate` can be used instead
    # of the native `date` if the `coreutils` package was installed)
    #
    # if [ "$(date +%N)" != "N" ] || \
    #    [ ! -x "$(command -v 'gdate')" ]; then
    #    dateCmd="date +%s.%N"
    # else
    #    dateCmd="gdate +%s.%N"
    # fi
    #
    # PS4="+$( tput cr && tput cuf 6 &&
    #          printf "$yellow %s $green%6s $reset" "$($dateCmd)" "[$LINENO]" )"
    #
    # PS4 output:
    #
    #   ++    1357074705.875970000  [123] '[' 1 == 0 ']'
    #   └──┬─┘└────┬───┘ └───┬───┘ └──┬─┘ └──────┬─────┘
    #      │       │         │        │          │
    #      │       │         │        │          └─ command
    #      │       │         │        └─ line number
    #      │       │         └─ nanoseconds
    #      │       └─ seconds since 1970-01-01 00:00:00 UTC
    #      └─ depth-level of the subshell

    PS4="+$( tput cr && tput cuf 6 && printf "%s $reset" )"

    export PS4

}



set_prompts
unset set_prompts

# ----------------------------------------------------------------------------------

. /Users/bocas/Development/z.sh
