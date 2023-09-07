#!/bin/zsh

########################################################################
#                                                                      #
# RunJava.sh: Compila e executa projeto Java                           #
#                                                                      # 
# Autor: Gabriel Silva Aires (gabrielsilvaaires62@gmailcom)            #    
# Data criação: 03/09/2023                                             # 
#                                                                      #      
# Descrição: Procura por todos os pacotes com arquivos .java e pelo    #
# método main, compila e executa todo o projeto a partir do terminal   #
#                                                                      #        
# Exemplo de uso: RunJava.sh | runjava (com alias)                     #
#                                                                      #     
########################################################################

clear 

OLDIFS=$IFS # "backup" do IFS
touch tempfile.txt # cria arquivo temporário que irá armazenar nome de cada arquivo da pasta src
ls src > tempfile.txt # redireciona os arquivos listados para pasta temporária

SRC="src/"
DIR_MAIN=""
CLASS_MAIN="" 
JAVA_COMPILE="javac -d bin"
JAVA_EXECUTE="java -cp bin"
COM_PACOTES=0
SEM_PACOTES=0

# loop para ler cada linha do arquivo temporário
while IFS= read -r FILE
do

  if [ -d "$SRC$FILE" ] # verifica se é um pacote (diretório)
  then

    if grep -q "public static void main(" "$SRC$FILE"/* 2>/dev/null # procura pelo método main
    then
      COM_PACOTES=1
      DIR_MAIN="$SRC$FILE"
      CLASS_MAIN=$(grep -rl "public static void main(" "$DIR_MAIN"/* 2>/dev/null | head -n 1) # atribui variável que contém classe com método main

      for SRC_FILES in src/*
      do
        JAVA_COMPILE="$JAVA_COMPILE $SRC_FILES/*.java" # Compila código com todos os pacotes existentes na pasta src
      done

      JAVA_EXECUTE="$JAVA_EXECUTE $CLASS_MAIN" # Atribuindo variável que de fato executa o projeto
    fi

  elif [ ! -d "$SRC$FILE" ] # verifica que não é um pacote (diretório)
    JAVA_COMPILE="$JAVA_COMPILE $SRC$FILE" # Compila código com todos os arquivos.java existentes na pasta src
  then 
    SEM_PACOTES=1

    if grep -q "public static void main(" "$SRC$FILE" 2>/dev/null # procura pelo método main
    then
      CLASS_MAIN="$SRC$FILE" # atribui variável que contém classe com método main
      CLASS_MAIN=$(basename "$CLASS_MAIN" .java) # remove conteúdo desnecessário de variável CLASS_MAIN
      JAVA_EXECUTE="$JAVA_EXECUTE $CLASS_MAIN" # Atribuindo variável que de fato executa o projeto
    fi

  fi

done < tempfile.txt

IFS=$OLDIFS
rm tempfile.txt # remove arquivo temporário

if [ "$COM_PACOTES" -eq 1 -o "$SEM_PACOTES" -eq 1 ] # Roda o projeto no terminal
then
  eval $JAVA_COMPILE
  eval $JAVA_EXECUTE
fi
