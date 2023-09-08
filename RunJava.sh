#!/bin/zsh

########################################################################
#                                                                      #
# RunJava.sh: Compile and execute Java project                         #
#                                                                      # 
# Author: Gabriel Silva Aires (gabrielsilvaaires@gmail.com)            #    
# Date: 09/03/2023                                                     # 
#                                                                      #      
# Description: Search for packages or files.java, compile and execute  #
# Java code from the terminal.                                         #
#                                                                      #        
# Example: RunJava.sh | runjava (com alias)                            #
#                                                                      #     
########################################################################

clear 

OLDIFS=$IFS # "backup" IFS
touch tempfile.txt # create temporary file and storage every file's name from src directory
ls src > tempfile.txt # redirect the listed files to the temporary file

SRC="src/"
DIR_MAIN=""
CLASS_MAIN="" 
JAVA_COMPILE="javac -d bin"
JAVA_EXECUTE="java -cp bin"
COM_PACOTES=0
SEM_PACOTES=0

# loop to read each line from the temporary file
while IFS= read -r FILE
do

  if [ -d "$SRC$FILE" ] # check if it's a package (directory)
  then

    if grep -q "public static void main(" "$SRC$FILE"/* 2>/dev/null # search for main method
    then
      COM_PACOTES=1
      DIR_MAIN="$SRC$FILE"
      CLASS_MAIN=$(grep -rl "public static void main(" "$DIR_MAIN"/* 2>/dev/null | head -n 1) # assign a variable that contains the class with the main method

      for SRC_FILES in src/*
      do
        JAVA_COMPILE="$JAVA_COMPILE $SRC_FILES/*.java" # compile code with all existing packages in the src folder
      done

      JAVA_EXECUTE="$JAVA_EXECUTE $CLASS_MAIN" # assign a variable that actually runs the project
    fi

  elif [ ! -d "$SRC$FILE" ] # check that it's not a package (directory)
    JAVA_COMPILE="$JAVA_COMPILE $SRC$FILE" # compile code with all .java files existing in the src folder
  then 
    SEM_PACOTES=1

    if grep -q "public static void main(" "$SRC$FILE" 2>/dev/null # search for main method
    then
      CLASS_MAIN="$SRC$FILE" # assign a variable that contains the class with the main method
      CLASS_MAIN=$(basename "$CLASS_MAIN" .java) # remove unnecessary content from the CLASS_MAIN variable
      JAVA_EXECUTE="$JAVA_EXECUTE $CLASS_MAIN" # assign a variable that actually runs the project
    fi

  fi

done < tempfile.txt

IFS=$OLDIFS
rm tempfile.txt # remove temporary file

if [ "$COM_PACOTES" -eq 1 -o "$SEM_PACOTES" -eq 1 ] # run project from the terminal
then
  eval $JAVA_COMPILE
  eval $JAVA_EXECUTE
fi
