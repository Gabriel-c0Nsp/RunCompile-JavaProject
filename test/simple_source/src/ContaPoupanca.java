public class ContaPoupanca extends ContaBancaria {

    private int diaRendimento;

    public ContaPoupanca(String nomeCliente, Long numConta, double saldo, int diaRendimento) {
        super(nomeCliente, numConta, saldo);
        this.diaRendimento = diaRendimento;
    }

    public int getDiaRendimento() {
        return diaRendimento;
    }

    public void setDiaRendimento(int diaRendimento) {
        this.diaRendimento = diaRendimento;
    }

    public double calcularNovoSaldo() {
        double taxaRendimento = 0.02; // 2% em forma decimal
        double rendimento = getSaldo() * taxaRendimento;
        double novoSaldo = getSaldo() + rendimento;
        setSaldo(novoSaldo);
        return novoSaldo;
    }

    public String toString() {
        return "Olá, " + getNomeCliente() + "\nO saldo atual da sua conta é: $" + String.format("%.2f%n", getSaldo());
    }
}