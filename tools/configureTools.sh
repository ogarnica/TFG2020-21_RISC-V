#------------------------------------------------------------------------------
# Archivo de configuracion PATHs para cada disenador que trabaja en el proyecto
#------------------------------------------------------------------------------

if [ "$(hostname)" = "pc-ogarnica" ]; then
   if  [ ! -d "/cygdrive/t" ]; then 
   subst T: Z:/Documentos/Devel
   fi
   export HOME_PROJECTS="T:"

elif [ "$(hostname)" = "pc-dennis" ]; then
   export HOME_PROJECTS="/home/dennis/Development/Hardware/Projects"
fi


export V_PRODUCT_NAME="$1"
export NAME_PROJECT=${V_PRODUCT_NAME}
export HOME_PROJECT=${HOME_PROJECTS}/${NAME_PROJECT}
export V_HDS="2010.2a"
export V_TOOL_ENTRY="HDS Designer 2012.2a"

#------------------------------------------------------------------------------
# Print project configuration
#------------------------------------------------------------------------------

echo ------------------------------------
echo Project home: ${HOME_PROJECTS}
echo Project name: ${NAME_PROJECT}
echo ------------------------------------
