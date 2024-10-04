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

4. Since this script navigates through your directories, you need to run it using the source command:
    ```bash
    source ./RunJava.sh
    ```

## Recommendations

You can easily run this script by simply typing `runjava` (or any alias you choose) in your terminal by setting aliases in your `.bashrc` or `.bash_profile`:

```bash
export PATH=$PATH:~/RunCompile-JavaProject
alias runjava='source ~/RunCompile-JavaProject/RunJava.sh'
```

Don't forget to adjust the path in the `export PATH=...` command as needed.

## Observation

Feel free to modify the script as necessary. I am open to questions and suggestions for improvement. Please keep in mind that this project may not be in its final version. If you encounter any errors, refer to the commit messages to check out a stable version, and pay attention to comments in the code that indicate potential instability."
