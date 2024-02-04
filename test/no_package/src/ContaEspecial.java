public class ContaEspecial extends ContaBancaria {

    private double limite;

    public ContaEspecial(String nomeCliente, Long numConta, double saldo, double limite) {
        super(nomeCliente, numConta, saldo);
        this.limite = limite;
    }

    public double getLimite() {
        return limite;
    }

    public void setLimite(double limite) {
        this.limite = limite;
    }

    @Override
    public double sacar(double valorSaque) {
        if (valorSaque < (getSaldo() + getLimite())) {
            double novoSaldo = getSaldo() - valorSaque;
            setSaldo(novoSaldo);
            return valorSaque;
        } else {
            System.out.println("Não foi possível realizar o saque do valor informado. Saldo insuficiente. Saldo atual: "
                    + getSaldo());
            return 0.0;
        }

    }
}