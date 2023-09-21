# Enter base enviroment
# source activate base
# Tell ls to be colourful
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

## command line
 export TERM="xterm-color"
 PS1='\[\e[0;33m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]:\[\e[0;35m\]\w\[\e[0m\]\$ '
## individual alias
alias rstudio='/Applications/RStudio.app/Contents/MacOS/RStudio &'
alias lesm='tail -n +1'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias le="less -S"
alias ls="ls --color=auto"
alias ll="ls -lh"
alias csv2xls="/Users/jlu/Documents/Softwares/csv2xls-master/csv_to_xls.py"
alias xlsx2csv="python /Users/jlu/.local/lib/python3.7/site-packages/xlsx2csv.py"
alias new="hexo n"
alias publish="rm -rf /Users/jlu/Desktop/GitHub/healixloo.github.io/.deploy_git;hexo clean;hexo g -d"
alias blog="cd /Users/jlu/Desktop/GitHub/healixloo.github.io"
alias update="cd /Users/jlu/Desktop/GitHub/healixloo.github.io;git add .;git commit -m 'add branch';git push"
#export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="$PATH:/anaconda3/bin:/Users/jlu/.local/bin/"
alias mouse="less -S /Users/jlu/Documents/GeneNameLibrary/Mouse_GeneName.txt" 
alias human="less -S /Users/jlu/Documents/GeneNameLibrary/Human_GeneName.txt"
alias SSHF="ssh -p 222 jlu@odin.leibniz-fli.de"
alias SSHM="ssh -p 222 jlu@gen100.leibniz-fli.de"
alias the_matrix="sh /Users/jlu/Desktop/Transcendence/WORKDIR/the_matrix.sh"

SCPF () {
scp -r -P 222 odin.leibniz-fli.de:"$1" "$2"
}
paperAI () {
. /Users/jlu/Softwares/ChatPaper-main/paperAI.sh "$1"
}


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jlu/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jlu/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/jlu/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jlu/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# Trash setting
mkdir -p ~/.Trash
alias rm=trash
alias rl='ls ~/.Trash'
alias ur=undelfile
alias rt=cleartrash
undelfile()
{
    mv -i ~/.Trash/* ./
}

trash()
{
    mv -i $@ ~/.Trash/
}

cleartrash()
{
    read -p "Clear trash sure?[n]" confirm
    [ $confirm == 'y' ] || [ $confirm == 'Y' ] && /bin/rm -rf ~/.Trash/*
}

# Save pro.sh into the enviroment
export PATH="$PATH:/Users/jlu/Desktop/Transcendence/bin"
# eval "$(/opt/homebrew/bin/brew shellenv)"

# Enter base enviroment
source activate base
# set home direcotry
cd /home
# launch jupyterhub in the background
jupyterhub --port 8787 --ip 0.0.0.0 > /dev/null 2>&1 &


