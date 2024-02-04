public abstract class ContaBancaria {

    private String nomeCliente;
    private Long numConta;
    private double saldo;

    public ContaBancaria(String nomeCliente, Long numConta, double saldo) {
        this.nomeCliente = nomeCliente;
        this.numConta = numConta;
        this.saldo = saldo;
    }

    public String getNomeCliente() {
        return nomeCliente;
    }

    public void setNomeCliente(String nomeCliente) {
        this.nomeCliente = nomeCliente;
    }

    public Long getNumConta() {
        return numConta;
    }

    public void setNumConta(Long numConta) {
        this.numConta = numConta;
    }

    public double getSaldo() {
        return saldo;
    }

    public void setSaldo(double saldo) {
        this.saldo = saldo;
    }

    public double sacar(double valorSaque) {
        if (valorSaque > getSaldo()) {
            System.out.println("Não foi possível sacar o valor informado. Saldo insuficiente.");
            return 0.0;
        }
        return getSaldo() - valorSaque;
    }

    public double depositar(double valorDeposito) {
        double novoSaldo = getSaldo() + valorDeposito;
        setSaldo(novoSaldo);
        return novoSaldo;
    }

    public String toString() {
        return "Olá, " + getNomeCliente() + "!" + "\nO saldo atual da sua conta é: $"
                + String.format("%.2f%n", getSaldo());
    }
}
