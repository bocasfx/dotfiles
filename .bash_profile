
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

export EDITOR="subl -w"

source ~/.bash_prompt
source ~/.alias
source ~/.functions

. /Users/bocas/Development/z.sh
