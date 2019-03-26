# Aliases y funciones de usuario

#################################################################### 
#######################	Aliases	#################################### 
#################################################################### 

# Da color al comando ls.
alias ls='ls --color=auto'
LS_COLORS=$LS_COLORS:'ex=1;32:'
export LS_COLORS

# Color de la coincidencia de grep.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Uso de versión de python (default: python2.7 <--- /usr/bin/python <--- /usr/bin/python2.7 ).
#alias python=python3

# Tamaño de la ventana de feh es de 800x600.
alias fehs='feh -g 800x600'

# htop y glances, refresh rate at 0.5 [s]. 
alias htop='htop -d 5'
alias glances='glances -1 -t 0.5'	# -1, --percpu          start Glances in per CPU mode

# ghostscript crea un pdf con las imagenes .eps de los archivos como argumento. En tamaño del ellas. (CREADO COMO FUNCIÓN)
#alias crearpdf='gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dEPSCrop -sOutputFile=temp.pdf'

# Cierra la sesión actual de cinnamon.
alias logout_cinnamon='gnome-session-quit'

# Abrevia el uso del comando para inciar etcher (create flash boot).
alias etcher='etcher-electron'

# alias para reproducir audio cuando trabajo terminado.
alias trabajo_terminado_exito='paplay /usr/share/sounds/freedesktop/stereo/trabajo_exito.wav'
alias trabajo_terminado_fracaso='paplay /usr/share/sounds/freedesktop/stereo/trabajo_fracaso.wav'

# alias para escanar redes visibles
alias getwifis='iwlist wlp2s0 scan'

# alias to list created virtual machines in virtualbox
alias lsVMs='VBoxManage list vms'

# alias to start the virtual machine 'Mierdows7' without GUI (background)
alias startWindowsVM='VBoxManage startvm Mierdows7 --type headless'

# alias to shutdown (forced) started virtual machines (here 'Mierdows7')
alias stopWindowsVM='VBoxManage controlvm Mierdows7 poweroff'

#################################################################### 
#######################	FUNCIONES	############################ 
#################################################################### 

lesscsv(){
	# Recibe archivo separado por comas como entrada, para verlo de forma comoda en la terminal.
	# Para archivos grandes es demoroso! (buscar otra manera)
	column -s, -t < "$1" | less -#2 -N -S
}

verepsenpdf(){
	# Convierte un serie de imagenes (recibidas como entrada) para ser convertidas a un único archivo PDF y luego abierto con OKULAR. 
	# El archivo creado es eliminado al cerrar OKULAR.
	# OJO: De cerrarse la terminal mantando el programa, no se elimina el archivo temporal.
	#
	#	Syntax:
	#		$ verepsenpdf Imagen1.eps Imagen2.eps
	#
	#		$ verepsenpdf Imagen*
	#
	gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dEPSCrop -sOutputFile=temp.pdf $* && 
	okular temp.pdf &&
	rm temp.pdf
}

PruebaImpresion(){
	# Jugando con los argumentos de una funcion en la shell para saber que significan...
	echo 'Primero:' $1
	echo 'Segundo:' $2
	echo 'Todos separados:' $@
	echo 'Todos juntos:' $*
	echo 'Desde el segundo input:' ${*:2}
	echo 'Número de inputs:' $#
	echo 'Último argumento:' ${*:$#}
	echo 'Todos los argumentos menos el último:' ${*:1:$#-1}
	echo 'Extensión del Nombre del primer archivo:' ${1##*.}
	echo 'Nombre sin extension (hasta ultimo punto) del primer archivo:' ${1%.*}
	}

crearNuevoPDF(){
	# Función que crea y abre un pdf en la ubicacion actual de los argumentos ingresados (imagenes de tipo  *.JPG, *.eps, *.pdf, *.png, *.bmp). Primer argumento es el nombre del archivo de salida (sin extensión).
	#
	#	Syntax:
	#		$ crearNuevoPDF SalidaPDF Imagen1.jpg Imagen2.eps Imagen3.JPG
	#
	#		$ crearNuevoPDF SalidaPDF Imagen*
	#
	NombreNuevoPDF=$1
	NumTemp=1
	for i in ${*:2}; do
		echo $i "NumTemp" $NumTemp
		# convierte las imagenes a JPG a un solo PDF
		if [ ${i##*.} == "JPG" ]; then
			#echo "${i%.*}"
			convert $i temp${NumTemp}.pdf
		
		# convierte las imagenes eps a pdf con gostscript
		elif [ ${i##*.} == "eps" ]; then
			gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dEPSCrop -sOutputFile=temp${NumTemp}.pdf $i
		
		# de ya poseer extensión pdf se le cambia el nombre a temp para ser identificado fácilmente
		elif [ ${i##*.} == "pdf" ]; then
			convert $i temp${NumTemp}.pdf

		# procesa imagenes png
		elif [ ${i##*.} == "png" ]; then
			convert $i temp${NumTemp}.pdf

		# procesa imagenes bmp
		elif [ ${i##*.} == "bmp" ]; then
			convert $i temp${NumTemp}.pdf

		else
			echo $i "No es considerado."
		fi

		NumTemp=$((NumTemp+1))
	done
	
	pdfunite temp* ${NombreNuevoPDF}.pdf
	rm temp*
	okular ${NombreNuevoPDF}.pdf
}

decriptar_pdf_owner(){
	# Permite desencriptar un pdf. Se debe remover clave usuario en primer lugar. 
	# Se crea nuevo archivo terminado en '_d.pdf'. Recordar incluir extensión (Rapidez con tabulación).
	#
	#	Syntax:
	#		$ decriptar_pdf_owner locked_pdf.pdf
	#
	qpdf --decrypt $1 ${1%.*}_d.pdf
}

PortalIngressRefreshTimer(){
	# Llama al script para contar el tiempo de refrescado cíclico.
	# Tiempo cada 6 minutos. (revisar script para mayor información).
	~/repite_cadaXmin.sh 6
}

gui_python_ui2py(){
	# Permite compilar la interaz visual de qt designer '.ui' en lenguaje python '.py'.
	# Utiliza la opción -x para asignar la opción ejecutable.
	pyuic4 -x ${1%.*}.ui -o ${1%.*}.py
}

alerta_finalizado(){
	# Repoduce un audio. De ser exitoso reproduce el alias 'trabajo_terminado_exito', de lo contrario el alias 'trabajo_terminado_fracaso'. Estos alias se encuentran en el archivo '.bash_aliases'
	# Utilizar luego de un commando con ';' para que se repoduzca correctamente.
	if [ $? -eq 0 ]
	then
		trabajo_terminado_exito
	else
		trabajo_terminado_fracaso
	fi
}

wdevices(){
	: '
	Función para escanear dispositivos en red wifi.
	Posee un único argumento opcional: ip de red local.
	Guarda la ip hasta ultimo punto y agrega '0/24' en caso de darse agumento, de lo
	contrario utiliza la retornada por función 'ip route'.

	Ejemplo1: wdevices 192.168.0.5
	# es traducido a la orden: sudo nmap -sn 192.168.0.0/24
	Ejemplo2: wdevices
	# es traducido a la orden: sudo nmap -sn 192.168.0.0/24
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

# Permite exportar la función para ser utilizada por otros scripts.
export -f alerta_finalizado
#type -a alerta_finalizado	# Permite conocer el contenido de una función


play_exito(){
	: '
	Función para repoducir sonidos de éxito con ogg123 luego
	que una tarea finalizara exitosamente. (apt-get isntall vorbis-tools)
	'
	RUTA_SONIDOS="/home/$(whoami)/Documentos/sonidos/exito/"
	ogg123 -q ${RUTA_SONIDOS}sfx_ui_success.ogg ${RUTA_SONIDOS}SiegeTank_Pissed00.ogg
}


play_fallo(){
	: '
	Función para repoducir sonidos de fracaso o fallo con ogg123 luego
	que una tarea NO finalizara exitosamente. (apt-get isntall vorbis-tools)
	'
	RUTA_SONIDOS="/home/$(whoami)/Documentos/sonidos/fallo/"
	ogg123 -q ${RUTA_SONIDOS}speech_unsuccessful.ogg ${RUTA_SONIDOS}SiegeTank_Pissed01.ogg
}


fin(){
        # Función que detecta si el último comando terminó exisosamente o no. 
        # Reproduce un sonido respectivo como respuesta a cada caso.
        '
        if [ $? -eq 0 ]; then
                play_exito;
        else
                play_fallo;
        fi
}
