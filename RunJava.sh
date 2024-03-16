#!/bin/bash

# THIS PROJECT IS NOT USABLE YET. FOR STABLE VERSION, USE PREVOIUS VERSIONS

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
# Example: RunJava.sh | runjava (alias)                                #
#                                                                      #     
########################################################################

clear

type_of_project=""
# options: "with_package", "no_package", "maven", "gradle"

go_to_root() {
  local found=0

  while [[ $found -ne 1 ]]; do
    if [[ -d "src" ]]; then
      echo "$(pwd)"
      cd "src"
      found=1
    else 
      if [[ "$(pwd)" != "$HOME" ]]; then
        cd ..
      else # then there is no src folder in the project
        break
      fi
    fi
  done 
}

get_type_of_project() {
  local found=0
  local current_path=$(pwd)

  while [[ $found -ne 1 ]]; do
    if [[ -d "src" ]]; then
      if [[ -e "build.gradle" ]]; then
        type_of_project="gradle"
      elif [[ -e "pom.xml" ]]; then
        type_of_project="maven"
      else
        type_of_project="with_package"
      fi
      found=1
    else 
      if [[ "$(pwd)" != "$HOME" ]]; then
        cd ..
      else 
        cd $current_path
        if find . -maxdepth 1 -type f -name "*.java" | grep -q .; then # check if there is any .java file
            type_of_project="no_package"
        fi
        break
      fi
    fi
  done 

  # check if type_of_project is empty
  if [[ -z $type_of_project ]]; then
    echo "This project is not a Java project"
  fi
  cd $current_path
}

get_type_of_project

# check if there is more than one .java file in the directory (in case of no package)
multiple_files=false

if [[ $type_of_project == "no_package" ]]; then
  java_files_count=$(find . -maxdepth 1 -type f -name "*.java" | wc -l)
  if (( java_files_count > 1 )); then
    multiple_files=true
  else
    one_file=false
  fi
fi
echo $multiple_files

# functions to compile and execute the project
gradle_run() {
  go_to_root

  gradle build
  gradle run
}

maven_run() {
  go_to_root

  mvn spring-boot:run
}
