# RunJava
## Description

`RunJava.sh` is a shell script designed to simplify the process of compiling and executing Java projects directly from the terminal. It searches for Java source files or packages, compiles them if necessary, and executes the main Java class.

## Get started

1. Clone the repository:
    ```bash
    git clone https://github.com/Gabriel-c0Nsp/RunCompile-JavaProject.git
    ```

2. Navigate to the repository:
    ```bash
    cd RunCompile-JavaProject
    ```

3. Make sure the script has executable permissions. If not, run the following command:
   ```bash
   chmod +x RunJava.sh
   ```

4. Since this script actually navigate through your directories, you need to run it using source command:
  ```bash
  source ./RunJava.sh
```
## Recommendations
You can easily run this script by simply just typing `runjava` (or whatever you want) in your terminal, by setting aliases to your `.bashrc` or `.bash_profile`.
```bash
  export PATH=$PATH:~/RunCompile-JavaProject
  alias runjava='source ~/RunCompile-JavaProject/RunJava.sh'
```
Don't forget to change the path in the `export PATH=...` command as needed.

## Observation
Feel free to make any modifications to the script as needed. I am open to questions and suggestions for improvement. Please remember that this project is likely not in its final version, so in case of errors, pay attention to commit messages (so you can checkout a stable version) and possible comments in the code indicating that the version is unstable for use.
