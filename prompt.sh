#!/bin/bash
##########################################################
#Please edit "User Configuration" section before using   #
##########################################################

#=========================================================
#Terminal Color Codes
#=========================================================
WHITE='\[\033[1;37m\]'
LIGHTGRAY='\[\033[0;37m\]'
GRAY='\[\033[1;30m\]'
BLACK='\[\033[0;30m\]'
RED='\[\033[0;31m\]'
LIGHTRED='\[\033[1;31m\]'
GREEN='\[\033[0;32m\]'
LIGHTGREEN='\[\033[1;32m\]'
BROWN='\[\033[0;33m\]' #Orange
YELLOW='\[\033[1;33m\]'
BLUE='\[\033[0;34m\]'
LIGHTBLUE='\[\033[1;34m\]'
PURPLE='\[\033[0;35m\]'
PINK='\[\033[1;35m\]' #Light Purple
CYAN='\[\033[0;36m\]'
LIGHTCYAN='\[\033[1;36m\]'
DEFAULT='\[\033[0m\]'

#=========================================================
# User Configuration
#=========================================================
# Colors
cLINES=$BLUE      #Lines and Arrow
cBRACKETS=$BLUE   # Brackets around each data item
cERROR=$LIGHTRED  # Error block when previous command did not return 0
cSUCCESS=$GREEN   # When last command ran successfully and return 0
cTIME=$LIGHTGRAY  # The current time
cMPX1=$YELLOW     # Color for terminal multiplexer threshold 1
cMPX2=$RED        # Color for terminal multiplexer threshold 2
cBGJ1=$YELLOW     # Color for background job threshold 1
cBGJ2=$RED        # Color for background job threshold 2
cSTJ1=$YELLOW     # Color for background job threshold 1
cSTJ2=$RED        # Color for  background job threshold 2
cSSH=$RED         # Color for brackets if session is an SSH session
cUSR=$GREEN       # Color of user
cUHS=$BLUE        # Color of the user and hostname separator, probably '@'
cHST=$GREEN       # Color of hostname
cRWN=$RED         # Color of root warning
cPWD=$GREEN       # Color of current directory
cGIT=$GREEN       # Color of git branch
cCMD=$DEFAULT     # Color of the command you type


# Enable block
eNL=1   # Have a newline between previous command output and new prompt
eERR=1  # Previous command return status tracker
eTIME=0 # Enable time display
eMPX=1  # Terminal multiplexer tracker enabled
eSSH=1  # Track if session is SSH
eBGJ=1  # Track background jobs
eSTJ=1  # Track stopped jobs
eHOST=1 # Show user and host
ePWD=1  # Show current directory, ignored if eNWA == 1
eGIT=1  # Show the git branch
eNWA=1  # Use the full network address of the CWD: user@host:/path/to/dir
eONLY=1 # Only show MPX,BGJ, and STJ when there are non-zero values.
eWRAP=1 # Enables the wrapping mechanism for prompt elements.

# Thresholds for jobs and sessions
MPXT1="0" # Terminal multiplexer threshold 1 value
MPXT2="2" # Terminal multiplexer threshold 2 value
BGJT1="0" # Background job threshold 1 value
BGJT2="2" # Background job threshold 2 value
STJT1="0" # Stopped job threshold 1 value
STJT2="2" # Stopped job threshold 2 value

# Elements/Icons and their coloring
UHS="@"

lbracket=$(printf '\xE2\xA6\x97')
lbracket="${cBRACKETS}${lbracket}" # = ${color}${symbol}

rbracket=$(printf '\xE2\xA6\x98')
rbracket="${cBRACKETS}${rbracket}"

connector="\342\224\200"
connector="${cLINES}${connector}"

two_line_connector_top=$(printf '\xE2\x95\xAD')
two_line_connector_top="${cLINES}${two_line_connector_top}"

two_line_connector_bottom=$(printf '\xE2\x95\xB0')
two_line_connector_bottom="${cLINES}${two_line_connector_bottom}"

extra_line_connector=$(printf '\xE2\x94\x9C')

terminator=$(printf '\xE2\x9E\xA4')
terminator="${cLINES}${terminator}"

dss_icon='\342\230\220'
bgj_icon='&'
stj_icon='\342\234\227'



# Function to return the current branch name
function parse_git_branch() {
       git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' \
                               | sed 's/^ *//g' \
                               | sed -e 's/^(*//g;s/)*$//g'
}

# Returns 1 if there are uncommitted/unstages work.
function git_unstaged_commits() {
  git status --porcelain 2> /dev/null | wc -l
}


# Arg1: prompt element to add to prompt
# Arg2: number of printable character in the prompt
# Adds the prompt element to PS1, adding a new line and 
#   extra_line_connector symbol if the element would be
#   wrapped.
function add_elem() {
  new_elem=$1
  len_new_elem=$2
  new_len=$(( $len_new_elem + $len_current))
  if [ $eWRAP -eq 1 ] && [ $new_len -ge $(( $COLUMNS - 5 )) ]; then
    PS1+="\n${extra_line_connector}"
    len_current=2
  fi
  PS1+="${new_elem}"
  len_current=$(( $len_current + $len_new_elem ))
}


# Function to assemble the prompt from various sub-components.
# The details of the prompt are controlled by the variables at
# the top of the file.
function promptcmd() {
  len_current=0
  prevret=$?

        #=========================================================
        #check if user is in ssh session
        #=========================================================
        if [ $eSSH -eq 1 ]; then
                if [[ $SSH_CLIENT ]] || [[ $SSH2_CLIENT ]]; then
                        lSSH_FLAG=1
                else
                        lSSH_FLAG=0
                fi
        fi

        #=========================================================
        # Insert a new line to clear space from previous command
        #=========================================================
        if [ $eNL -eq 1 ]; then
                PS1="\n"
        else
                PS1=""
        fi

        #=========================================================
        # Beginning of first line (arrow wrap around and color setup)
        #=========================================================
        #PS1="${PS1}${cLINES}\342\224\214\342\224\200"
        num_char=1
        add_elem "${two_line_connector_top}" $num_char


        #=========================================================
        # First Dynamic Block - Previous Command Error
        #=========================================================
        if [ $eERR -eq 1 ]; then
                pcom_color=$cSUCCESS
                if [ $prevret -ne 0 ] ; then
                  pcom_color=$cERROR
                fi
                #PS1+="${connector}${lbracket}${pcom_color}${prevret}${rbracket}"
                num_char=4
                add_elem "${connector}${lbracket}${pcom_color}${prevret}${rbracket}" $num_char
        fi

        #=========================================================
        # First static block - Current time
        #=========================================================
        if [ $eTIME -eq 1 ] ; then
                #PS1+="${connector}${lbracket}${cTIME}\t${rbracket}"
                num_char=4
                add_elem "${connector}${lbracket}${cTIME}\t${rbracket}" $num_char
        fi

        #=========================================================
        # Detached Screen Sessions
        #=========================================================
        #TODO This doesn't work
        if [ $eMPX -eq 1 ] ; then
                hTMUX=0
                hSCREEN=0
                MPXC=0
                hash tmux --help 2>/dev/null || hTMUX=1
                hash screen --version 2>/dev/null || hSCREEN=1
                if [ $hTMUX -eq 0 ] && [ $hSCREEN -eq 0 ] ; then
                        MPXC=$(echo "$(screen -ls | grep -c -i detach) + $(tmux ls 2>/dev/null | grep -c -i -v attach)" | bc)
                elif [ $hTMUX -eq 0 ] && [ $hSCREEN -eq 1 ] ; then
                        MPXC=$(tmux ls 2>/dev/null | grep -c -i -v attach)
                elif [ $hTMUX -eq 1 ] && [ $hSCREEN -eq 0 ] ; then
                        MPXC=$(screen -ls | grep -c -i detach)
                fi
                dss_color=$cSUCCESS
                if [[ $MPXC -gt $MPXT2 ]] ; then
                  dss_color=$cMPX2
                elif [[ $MPXC -gt $MPXT1 ]] ; then
                  dss_color=$cMPX1
                fi
                if [ $dss_color != $cSUCCESS ] || [ $eONLY -ne 1 ]; then
                  #PS1+="${connector}${lbracket}${dss_color}${dss_icon}:${MPXC}${rbracket}"
                  num_char=6
                  add_elem "${connector}${lbracket}${dss_color}${dss_icon}:${MPXC}${rbracket}" $num_char
                fi
        fi
        #=========================================================
        # Backgrounded running jobs
        #=========================================================
        if [ $eBGJ -eq 1 ] ; then
                BGJC=$(jobs -r | wc -l )
                bgjc_color=$cSUCCESS
                if [ $BGJC -gt $BGJT2 ] ; then
                  bgjc_color=$cBGJ2
                elif [ $BGJC -gt $BGJT1 ] ; then
                  bgjc_color=$cBGJ1
                fi
                if [ $bgjc_color != $cSUCCESS ] || [ $eONLY -ne 1 ]; then
                  #PS1+="${connector}${lbracket}${bgjc_color}${bgj_icon}:${BGJC}${rbracket}"
                  num_char=6
                  add_elem "${connector}${lbracket}${bgjc_color}${bgj_icon}:${BGJC}${rbracket}" $num_char
                fi
        fi

        #=========================================================
        # Stopped Jobs
        #=========================================================
        if [ $eSTJ -eq 1 ] ; then
                STJC=$(jobs -s | wc -l )
                stj_color=$cSUCCESS
                if [ $STJC -gt $STJT2 ] ; then
                  stj_color=$cSTJ2
                elif [ $STJC -gt $STJT1 ] ; then
                  stj_color=$cSTJ1
                fi
                if [ $stj_color != $cSUCCESS ] || [ $eONLY -ne 1 ]; then
                  #PS1+="${connector}${lbracket}${stj_color}${stj_icon}:${STJC}${rbracket}"
                  num_char=6
                  add_elem "${connector}${lbracket}${stj_color}${stj_icon}:${STJC}${rbracket}" $num_char
                fi
        fi

        #=========================================================
        # Second Static block - User@host
        #=========================================================
        # set color for brackets if user is in ssh session
        if [ $eSSH -eq 1 ] && [ $lSSH_FLAG -eq 1 ] ; then
                sesClr="$cSSH"
        else
                sesClr="$cBRACKETS"
        fi
        # don't display user if root
        num_char=2
        ssblock="${connector}${sesClr}${lbracket}"
        if [ $EUID -eq 0 ] ; then
          num_char=$(( $num_char + 1 ))
          ssblock+="${cRWN}!"
        else
          num_char=$(( $num_char + "${#USER}" ))
          ssblock+="${cUSR}\u"
        fi
        # Host Section
        if [[ $eNWA -eq 1 ]]; then
          PWD=$(pwd)
          num_char=$(( $num_char + "${#HOSTNAME}" + "${#PWD}" + 3 ))
          ssblock+="${cUHS}${UHS}${cHST}\h:${PWD}${sesClr}${rbracket}"
          
        elif [ $eHOST -eq 1 ] || [ $lSSH_FLAG -eq 1 ]; then   # Host is optional only without SSH
          num_chars=$(( $num_char + ${#HOSTNAME} + 2 ))
          ssblock+="${cUHS}${UHS}${cHST}\h${sesClr}${rbracket}"
        else
          num_char=$(( $num_char + 1 ))
          ssblock+="${sesClr}${rbracket}"
        fi
        add_elem $ssblock $num_char

        #=========================================================
        # Third Static Block - Current Directory
        #=========================================================
        if [ $ePWD -eq 1 ] && [ $eNWA -ne 1 ]; then
          PWD=$(pwd)
          num_char=$(( "${#PWD}" + 4 ))
          add_elem "${connector}${lbracket}${cPWD}${PWD}${rbracket}" $num_char
        fi



        #=========================================================
        # Fourth Block - GIT Branch
        #=========================================================
        cur_len=$(echo ${#PS1})
        if [ $eGIT -eq 1 ]; then
          branch_name=$(parse_git_branch)
          unstaged=$(git_unstaged_commits)
          branch_color=$cGIT
          if [ $unstaged -ge 1 ]; then
            branch_color=$cERROR
          fi
          if [ ! -z "$branch_name" ]; then
            #PS1+="${connector}${lbracket}${branch_color}${branch_name}${rbracket}"
            num_char=$(( ${#branch_name} + 4 ))
            add_elem "${connector}${lbracket}${branch_color}${branch_name}${rbracket}" $num_char
          fi
        fi


        #=========================================================
        # Second Line
        #=========================================================
        PS1+="\n${two_line_connector_bottom}${connector}${terminator} ${cCMD}"
}

function load_prompt () {
    # Get PIDs
    local parent_process=$(tr -d '\0' < /proc/$PPID/cmdline | cut -d \. -f 1)
    local my_process=$(tr -d '\0' < /proc/$$/cmdline | cut -d \. -f 1)

    if  [[ $parent_process == script* ]]; then
        PROMPT_COMMAND=""
        PS1="\t - \# - \u@\H { \w }\$ "
    elif [[ $parent_process == emacs* || $parent_process == xemacs* ]]; then
        PROMPT_COMMAND=""
        PS1="\u@\h { \w }\$ "
    else
        export DAY=$(date +%A)
        PROMPT_COMMAND=promptcmd
     fi
    export PS1 PROMPT_COMMAND
}

load_prompt
