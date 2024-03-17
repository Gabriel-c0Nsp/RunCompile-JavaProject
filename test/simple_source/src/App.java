import java.util.Scanner;
import java.util.Locale;
import java.util.Random;

public class App {

    public static void main(String[] args) {

        Locale.setDefault(Locale.US);
        Scanner scanner = new Scanner(System.in);
        Random random = new Random();

        ContaPoupanca contaPoupanca = null;
        ContaEspecial contaEspecial = null;

        char escolha;
        char escolhaTipoConta;
        boolean valorInvalido = false;
        String nome;
        Long numeroConta;
        double saldo;
        int diaRendimento;
        double limite;
        char escolhaSaque;
        char escolhaDeposito;
        double valorSaque;
        double valorDeposito;

        System.out.println("Deseja criar uma conta?");
        System.out.println("(S)sim      |      (N)não");
        escolha = scanner.next().charAt(0);
        System.out.println();

        do {
            if (escolha == 's' || escolha == 'S') {
                System.out.println("Qual o tipo de conta deseja criar?");
                System.out.println("1(Conta Poupança)      |      2(Conta Especial)");
                escolhaTipoConta = scanner.next().charAt(0);

                if (escolhaTipoConta == '1') {
                    System.out.print("Informe o seu nome para cadastro: ");
                    scanner.nextLine();
                    nome = scanner.nextLine();
                    System.out.println();
                    numeroConta = random.nextLong();
                    numeroConta = Math.abs(numeroConta);
                    System.out.println("O número da sua conta é: " + numeroConta);
                    System.out.println("ATENÇÃO! NÃO COMPARTILHE ESSE NÚMERO");
                    System.out.println();
                    System.out.print("Informe o dia de rendimento para a sua conta: ");
                    diaRendimento = scanner.nextInt();

                    if (diaRendimento <= 0 || diaRendimento > 30) {
                        System.out
                                .println("O dia Informado é inválido. Operação finalizada com erro. Tente novamente!");
                        valorInvalido = true;
                    } else {
                        valorInvalido = false;
                    }

                    saldo = 0.0;

                    contaPoupanca = new ContaPoupanca(nome, numeroConta, saldo, diaRendimento);

                    contaPoupanca.setNomeCliente(nome);
                    contaPoupanca.setNumConta(numeroConta);
                    contaPoupanca.setDiaRendimento(diaRendimento);
                    contaPoupanca.setSaldo(saldo);

                    if (contaPoupanca == null || valorInvalido == true) {
                        System.out.println("Infelizmente o processo de criação da sua conta falhou. Tente novamente!");
                        valorInvalido = true;
                    } else {
                        System.out.println(
                                "Parabéns!!! A sua conta foi criada com sucesso. Seja bem vindo ao nosso banco!");
                        valorInvalido = false;
                    }

                } else if (escolhaTipoConta == '2') {
                    System.out.print("Informe o seu nome para cadastro: ");
                    scanner.nextLine();
                    nome = scanner.nextLine();
                    System.out.println();
                    numeroConta = random.nextLong();
                    numeroConta = Math.abs(numeroConta);
                    System.out.println("O número da sua conta é: " + numeroConta);
                    System.out.println("ATENÇÃO! NÃO COMPARTILHE ESSE NÚMERO");
                    saldo = 0.0;
                    System.out.println();
                    System.out.println("Você possui um limite de $2500,00");
                    limite = 2500;

                    contaEspecial = new ContaEspecial(nome, numeroConta, saldo, limite);

                    contaEspecial.setNomeCliente(nome);
                    contaEspecial.setNumConta(numeroConta);
                    contaEspecial.setSaldo(saldo);
                    contaEspecial.setLimite(limite);
                     
                    

                    if (contaEspecial == null) {
                        System.out.println("Infelizmente o processo de criação da sua conta falhou. Tente novamente!");
                        valorInvalido = true;
                    } else {
                        valorInvalido = false;
                    }
                } else {
                    System.out.println("Opção inválida! Digite novamente.");
                    valorInvalido = true;
                }
            }

        } while (valorInvalido);

        if (contaPoupanca != null && !valorInvalido) {
            System.out.println();
            System.out.println("Deseja realizar algum saque?");
            System.out.println("(S)sim      |      (N)não");
            escolhaSaque = scanner.next().charAt(0);

            if (escolhaSaque == 'S' || escolhaSaque == 's') {
                System.out.print("Informe o valor do saque: ");
                valorSaque = scanner.nextDouble();
                contaPoupanca.sacar(valorSaque);
                System.out.printf("O saldo atualizado da sua conta é de $%.2f%n", contaPoupanca.calcularNovoSaldo());

            }

            System.out.println();
            System.out.println("Deseja realizar algum depósito?");
            System.out.println("(S)sim      |      (N)não");
            escolhaDeposito = scanner.next().charAt(0);

            if (escolhaDeposito == 'S' || escolhaDeposito == 's') {
                System.out.print("Insira o valor de depósito: ");
                valorDeposito = scanner.nextDouble();
                contaPoupanca.depositar(valorDeposito);
                System.out.println("Depósito realizado com sucesso!");
                System.out.println();
                System.out.println(contaPoupanca);
                System.out.println("E o saldo a partir do rendimento será de: " + contaPoupanca.calcularNovoSaldo());

            }
        }

        if (contaEspecial != null && !valorInvalido) {
            System.out.println();
            System.out.println("Deseja realizar algum saque?");
            System.out.println("(S)sim      |      (N)não");
            escolhaSaque = scanner.next().charAt(0);

            if (escolhaSaque == 'S' || escolhaSaque == 's') {
                System.out.print("Informe o valor do saque: ");
                valorSaque = scanner.nextDouble();
                contaEspecial.sacar(valorSaque);
                contaEspecial.toString();
            }

            System.out.println();
            System.out.println("Deseja realizar algum depósito?");
            System.out.println("(S)sim      |      (N)não");
            escolhaDeposito = scanner.next().charAt(0);

            if (escolhaDeposito == 'S' || escolhaDeposito == 's') {
                System.out.print("Insira o valor de depósito: ");
                valorDeposito = scanner.nextDouble();
                contaEspecial.depositar(valorDeposito);
                System.out.println("Depósito realizado com sucesso!");
                System.out.println();
                System.out.println(contaEspecial);
            }
        }

        scanner.close();

    }
}
