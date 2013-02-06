##
# Flash trace
##
alias trace="tail -f /Users/adrianmiranda/Library/Preferences/Macromedia/Flash\ Player/Logs/flashlog.txt"
test -r /sw/bin/init.sh && . /sw/bin/init.sh

##
# Exibe o nome do branch em que está trabalhando.
# P.S.: Para esse comando fazer efeito, rode esse comando, abaixo:
# git config --global color.ui "auto"
# sudo su -l
##
PS1='[\[\033[0;37m\]\u\[\033[1;37m\]@\h\[\033[00m\]] \[\033[1;34m\]\w\[\033[00m\]$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo " \[\033[1;33m\]($(git branch | grep ^*|sed s/\*\ //))\[\033[00m\]"; fi)\n\$ '

##
# Grep e ls color
##
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="4;33"
export CLICOLOR="auto"
alias ls="ls -G"

##
# Your previous /Users/adrianmiranda/.bash_profile file was backed up as /Users/adrianmiranda/.bash_profile.macports-saved_2012-01-29_at_13:25:56
##

# MacPorts Installer addition on 2012-01-29_at_13:25:56: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


# Setting PATH for MacPython 2.6
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"
export PATH

export XUGGLE_HOME="/usr/local/xuggler"

export TRACKER_HOME="/usr/local/tracker"

##
# Your previous /Users/adrianmiranda/.bash_profile file was backed up as /Users/adrianmiranda/.bash_profile.macports-saved_2012-12-31_at_21:57:02
##

# MacPorts Installer addition on 2012-12-31_at_21:57:02: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

