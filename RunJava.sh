#!/bin/zsh

########################################################################
#                                                                      #
# RunJava.sh: Compila e executa projeto Java                           #
#                                                                      # 
# Auto: Gabriel Silva (gabrielsivaaires64@gmail.com)                   #    
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

  if [ -d "$SRC$FILE" ] # verifica se é um pacote
  then

    if grep -q "public static void main(" "$SRC$FILE"/* 2>/dev/null # procura pelo método main
    then
      COM_PACOTES=1
      DIR_MAIN="$SRC$FILE"
      CLASS_MAIN=$(grep -rl "public static void main(" "$DIR_MAIN"/* 2>/dev/null | head -n 1) 

      for SRC_FILES in src/*
      do
        JAVA_COMPILE="$JAVA_COMPILE $SRC_FILES/*.java" # Compila código com todos os pacotes existentes na pasta src
      done

    JAVA_EXECUTE="$JAVA_EXECUTE $CLASS_MAIN" # Atribuindo variável que de fato executa o projeto
    fi

  # else TODO quando não houver pacotes
  #   
  fi
      
done < tempfile.txt

IFS=$OLDIFS
rm tempfile.txt

if [ "$COM_PACOTES" -eq 1 -o "$SEM_PACOTES" -eq 1 ]
then
  echo "teste"
  # TODO implementar lógica de execução aqui
fi
