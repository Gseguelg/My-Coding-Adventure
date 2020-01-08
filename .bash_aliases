# Aliases and user functions

#################################################################### 
########################	Aliases 	####################
#################################################################### 

# Specific color to ls command
# fuente: https://linuxhint.com/ls_colors_bash
alias ls='ls --color=auto'
LS_COLORS=$LS_COLORS:'ex=1;32:'  # ex: executable files; 1: Bold; 32: Green
export LS_COLORS

# Automatic color on grep coincidence
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Change default version of python (default: python2.7 <--- /usr/bin/python <--- /usr/bin/python2.7 ).
#alias python=python3

# htop y glances, refresh rate at 0.5 [s]. 
alias htop='htop -d 5'
alias glances='glances -1 -t 0.5'	# -1, --percpu          start Glances in per CPU mode

# ghostscript create a pdf with .eps images from input files. Keep file size.
#alias crearpdf='gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dEPSCrop -sOutputFile=temp.pdf'

# Close current cinnamen season
alias logout_cinnamon='gnome-session-quit'

# Shorten the command for etcher (create flash boot).
alias etcher='etcher-electron'

# Scan visible networks
alias getwifis='iwlist wlp2s0 scan'

# List created virtual machines inside virtualbox
alias lsVMs='VBoxManage list vms'

# Start virtual machine called 'Mierdows7' without GUI (background/headless)
alias startWindowsVM='VBoxManage startvm Mierdows7 --type headless'

# Forced shutdown running virtual machine (here 'Mierdows7')
alias stopWindowsVM='VBoxManage controlvm Mierdows7 poweroff'

# Play finishing sound. Audio not default, folder is though.
alias job_sound_success='paplay /usr/share/sounds/freedesktop/stereo/trabajo_exito.wav'
alias job_sound_failed='paplay /usr/share/sounds/freedesktop/stereo/trabajo_fracaso.wav'

#################################################################### 
########################	FUNCTIONS	####################
#################################################################### 

alert_me(){
	# Plays an audio signal at prevoius job/task ending. Sounds come from predefinied aliases wheather the job success or fails.
	# Must be used after desired command with a semicolon ';'.
	#
	#	Syntax:
	#		$ some_slow_command its_args; alert_me
	#
	if [ $? -eq 0 ]
	then
		job_sound_success
	else
		job_sound_failed
	fi
}

# Allows the function to be used by other scripts.
export -f alert_me
#type -a alert_me	# Function content is visible.

#play_exito(){
#	: '
#	Función para repoducir sonidos de éxito con ogg123 luego
#	que una tarea finalizara exitosamente. (apt-get isntall vorbis-tools)
#	'
#	RUTA_SONIDOS="/home/$(whoami)/Documentos/sonidos/exito/"
#	ogg123 -q ${RUTA_SONIDOS}sfx_ui_success.ogg ${RUTA_SONIDOS}SiegeTank_Pissed00.ogg
#}
#play_fallo(){
#	: '
#	Función para repoducir sonidos de fracaso o fallo con ogg123 luego
#	que una tarea NO finalizara exitosamente. (apt-get isntall vorbis-tools)
#	'
#	RUTA_SONIDOS="/home/$(whoami)/Documentos/sonidos/fallo/"
#	ogg123 -q ${RUTA_SONIDOS}speech_unsuccessful.ogg ${RUTA_SONIDOS}SiegeTank_Pissed01.ogg
#}
#fin(){
#        # Función que detecta si el último comando terminó exisosamente o no. 
#        # Reproduce un sonido respectivo como respuesta a cada caso.
#        '
#        if [ $? -eq 0 ]; then
#                play_exito;
#        else
#                play_fallo;
#        fi
#}

lesscsv(){
	# Splits input *.csv file to visualize columns within the terminal.
	# Warning! Large size required too much time.
	#
	#	Syntax:
	#		$ lesscsv some_small_fila.csv
	#		$ # use 'q' to quit.
	#
	column -s, -t < "$1" | less -#2 -N -S
}

eps2temp1pdf(){
	# Converts all input *.eps images and join them in a single *.pdf file on each page.
	# File is opened in okular and temporary file is deleted once it's closed.
	# Warning: If process is kileld, temp.pdf is not deleted.
	#
	#	Syntax:
	#		$ eps2temp1pdf Imagen1.eps Imagen2.eps
	#
	#		$ eps2temp1pdf Imagen*
	#
	gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dEPSCrop -sOutputFile=temp.pdf $* && 
	okular temp.pdf &&
	rm temp.pdf
}

images2pdf(){
	# Creates a single *.pdf from input images and opens it with okular.
	# First argument is the output pdf filename without extension.
	# Warning: Uses temp(number).pdf to create a temporarly copy for each input image
	# 	   to unite them later. If any file already exists on current directory
	#	   it'll be added to the final pdf.
	#
	# Extensions allowed:
	#			*.JPG
	#			*.eps
	#			*.pdf
	#			*.png
	#			*.bmp
	#
	#	Syntax:
	#		$ images2pdf OutputPDF Imagen1.jpg Imagen2.eps Imagen3.JPG
	#
	#		$ images2pdf OutputPDF Imagen*
	#
	NombreNuevoPDF=$1
	NumTemp=1
	for i in ${*:2}; do
		echo $i "NumTemp" $NumTemp
		# convierts JPG images to single PDF
		if [ ${i##*.} == "JPG" ]; then
			#echo "${i%.*}"
			convert $i temp${NumTemp}.pdf
		
		# convierts eps images to single pdf with gostscript
		elif [ ${i##*.} == "eps" ]; then
			gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dEPSCrop -sOutputFile=temp${NumTemp}.pdf $i
		
		# if already on pdf copy with new name to be identified
		elif [ ${i##*.} == "pdf" ]; then
			convert $i temp${NumTemp}.pdf

		# converts png images
		elif [ ${i##*.} == "png" ]; then
			convert $i temp${NumTemp}.pdf

		# converts bmp images
		elif [ ${i##*.} == "bmp" ]; then
			convert $i temp${NumTemp}.pdf

		else
			echo $i "not used."
		fi

		NumTemp=$((NumTemp+1))
	done
	
	pdfunite temp* ${NombreNuevoPDF}.pdf
	rm temp*
	okular ${NombreNuevoPDF}.pdf
}

decrypt_pdf_owner(){
	# Decrypts a pdf and created a new file '*_d.pdf'. User password must be firstly removed to be used.
	# Argument filename must be inputed with it's extension (for tab completion).
	#
	#	Syntax:
	#		$ decrypt_pdf_owner locked_pdf.pdf
	#
	qpdf --decrypt $1 ${1%.*}_d.pdf
}

wdevices(){
	: '
	Scan for local wifi devices by 'nmap -sn' implementation. Uses by default '0/24' Networks.
	Requieres sudo access to reveal all information possible.
	
	Optional argument: local ip network. When none is given searches on 'ip route' command output.
	

	Example 1: $ wdevices 192.168.0.5
	# gets translated to: $ sudo nmap -sn 192.168.0.0/24
	Example 2: $ wdevices
	# gets translated to: $ sudo nmap -sn 192.168.0.0/24
	'
	LocalNetworkIP="${1%.*}.0/24"
	if [ $# -eq 0 ]; then
		# en caso que no se entrege direccion.
		echo "Using local network"
		LocalNetworkName=$(ip route | grep kernel | awk '{ print( $3 ) }')
		LocalNetworkIP=$(ip route | grep kernel | awk '{ print( $1 ) }')
	fi
	echo "Checking Local IP $LocalNetworkIP"
	echo "Command to run: 'sudo nmap -sn $LocalNetworkIP'"
	sudo nmap -sn $LocalNetworkIP
}

