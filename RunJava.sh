#!/bin/zsh

########################################################################
#                                                                      #
# RunJava.sh: Compila e executa projeto Java                           #
#                                                                      # 
# Auto: Gabriel Silva (gabrielsivaaires63@gmail.com)                   #    
# Data criação: 02/09/2023                                             # 
#                                                                      #      
# Descrição: Procura por todos os pacotes com arquivos .java e pelo    #
# método main, compila e executa todo o projeto a partir do terminal   #
#                                                                      #        
# Exemplo de uso: RunJava.sh | runjava (com alias)                     #
#                                                                      #     
########################################################################


# Encontra todos os arquivos .java no diretório src e subdiretórios
find src -name "*.java" > sources.txt # criação de arquivo temporário para segurar argumentos
mkdir -p bin
javac -d bin @sources.txt # compilação

# Lista de classes com o método main
classes_com_main=()

# Loop para encontrar classes com o método main
while IFS= read -r file; do
    if grep -qF "public static void main(String[]" "$file"; then
        # Extrai o nome da classe do caminho do arquivo
        class_name=$(basename "$file" .java)
        classes_com_main+=("$class_name")
    fi
done < sources.txt


# Executa as classes com o método main
for class in "${classes_com_main[@]}"; do
    java -cp bin "$class"
done

# Limpa o arquivo temporário
rm sources.txt

