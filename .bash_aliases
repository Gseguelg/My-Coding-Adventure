# User specific aliases and functions

alias ls='ls --color=auto'
LS_COLORS=$LS_COLORS:'ex=1;32:'
export LS_COLORS

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#alias python=python3
alias fehs='feh -g 800x600'
# htop refresh rate at 0.5 [s]
alias htop='htop -d 5'
alias glances='glances -1 -t 0.5'

# ghostscript crea un pdf con las imagenes .eps de los archivos como argumento. En tamaño del ellas.
#alias crearpdf='gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dEPSCrop -sOutputFile=temp.pdf'

alias logout_cinnamon='gnome-session-quit'
alias etcher='etcher-electron'

# alias para reproducir audio cuando trabajo termindo
alias trabajo_terminado_exito='paplay /usr/share/sounds/freedesktop/stereo/trabajo_exito.wav'
alias trabajo_terminado_fracaso='paplay /usr/share/sounds/freedesktop/stereo/trabajo_fracaso.wav'
