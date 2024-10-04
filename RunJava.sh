#!/bin/sh

########################################################################
#                                                                      #
# RunJava.sh: Compile and execute Java project                         #
#                                                                      # 
# Author: Gabriel Silva Aires (gabrielsilvaaires@gmail.com)            #    
# Date: 03/09/2023                                                     # 
#                                                                      #      
# Description: Search for packages or files.java, compile and execute  #
# Java code from the terminal.                                         #
#                                                                      #        
# Example: RunJava.sh | runjava (alias)                                #
#                                                                      #     
########################################################################

clear

type_of_project=""
current_path=$(pwd)

go_to_source() {
  local found=0

  while [[ $found -ne 1 ]]; do
    if [[ -d "src" ]]; then
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

go_to_root() {
  local found=0

  while [[ $found -ne 1 ]]; do
    if [[ -d "src" ]]; then
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
    echo "This is not a Java project"
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

# check if there packages in the project
if [[ $type_of_project == "with_package" ]]; then
  go_to_source
  if ! [[ -n "$(find . -mindepth 1 -maxdepth 1 -type d)" ]]; then
    type_of_project="simple_source"
  fi
fi

# check if it's a SpringBoot project
if [[ $type_of_project == "maven" ]]; then
  go_to_root
  if grep -q "spring-boot-starter-parent" pom.xml; then 
    type_of_project="spring"
  else
    type_of_project="maven"
  fi
fi

# functions to compile and execute the project
gradle_run() {
  go_to_source
  gradle build
  gradle run
}

spring_run() {
  mvn spring-boot:run
}

maven_run() {
  mvn compile
  main_class=$(find_main)
  main_class_name=$(basename "$main_class" .java)

  # convert the path to package format
  package_name=$(dirname "$main_class" | sed 's|src/||;s|/|.|g')

  full_main_class="${package_name}.${main_class_name}"

  # If the name of the main class is "main", then use only the package_name
  if [[ "$main_class_name" == "main" ]]; then
    full_main_class="$package_name"
  fi

  mvn exec:java -Dexec.mainClass="${full_main_class/main.java./}"
}

one_file_run() {
  java *.java 
}

multiple_files_run() {
  local files=()
  local i=1

# lists the .java files in the current directory and removes the prefix './' and the extension '.java'
  for file in *.java; do
    file_name=$(basename "$file" .java)
    files+=("$file_name")
  done

  # menu for the user 
  echo "Choose the file you want to execute: "
  for file_name in "${files[@]}"; do
    echo "$i) $file_name"
    ((i++))
  done

  echo
  echo -n "--> "
  read choice

  # check if the user input is valid
  if [[ "$choice" =~ ^[1-${#files[@]}]$ ]]; then
    desired_file="${files[$((choice - 1))]}"
    clear
    java "$desired_file".java
  else
    clear
    echo "Invalid choice. Please enter a number between 1 and ${#files[@]}"
    echo
    multiple_files_run
  fi
}

# contains the main method of the project
find_main() {
  go_to_source

  main_file="src/$(grep -rl "public static void main" . | sed 's|^./||')"
  echo "$main_file"
}


simple_source_run() {
  go_to_root

  main_file=$(find_main)

  javac -d bin src/*.java
  java -cp bin "$main_file"
}

with_package_run() {
  go_to_root

  local compile_command="javac -d bin "

# Recursive function to traverse the directory tree
  find_packages() {
    local dir="$1"
    for file in "$dir"/*; do
      if [[ -f "$file" && "$file" == *.java ]]; then
        compile_command+="$dir/*.java "
      elif [[ -d "$file" ]]; then
        find_packages "$file"
      fi
    done
  }

  find_packages .

  #compile and execute process
  main_file=$(find_main)
  $compile_command
  java -cp bin "$main_file"
}

if [[ $type_of_project == "gradle" ]]; then
  gradle_run
elif [[ $type_of_project == "spring" ]]; then
  spring_run
elif [[ $type_of_project == "maven" ]]; then
  maven_run
elif [[ $type_of_project == "no_package" ]]; then
  if [[ $multiple_files == true ]]; then
    multiple_files_run
  else
    one_file_run
  fi
elif [[ $type_of_project == "simple_source" ]]; then
  simple_source_run
elif [[ $type_of_project == "with_package" ]]; then
  with_package_run
fi

cd $current_path
