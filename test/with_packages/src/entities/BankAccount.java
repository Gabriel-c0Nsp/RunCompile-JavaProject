package entities;

public class BankAccount {

  private long accountNumber;
  private String ownerName;
  private double initialDeposit;
  private double balance;
  private double depositValue;
  private double withdraw;

  public double getWithdraw() {
    return withdraw;
  }

  public void setWithdraw(double withdraw) {
    this.withdraw = withdraw;
  }

  public BankAccount(long accountNumber, String ownerName) {
    this.accountNumber = accountNumber;
    this.ownerName = ownerName;
  }

  public BankAccount(long accountNumber, String ownerName, double initialDeposit) {
    this.accountNumber = accountNumber;
    this.ownerName = ownerName;
    this.initialDeposit = initialDeposit;
  }

  public long getAccountNumber() {
    return accountNumber;
  }

  public String getOwnerName() {
    return ownerName;
  }

  public void setOwnerName(String ownerName) {
    this.ownerName = ownerName;
  }

  public double getInitialDeposit() {
    return initialDeposit;
  }

  public void setInitialDeposit(double initialDeposit) {
    this.initialDeposit = initialDeposit;
  }

  public double getBalance() {
    return balance;
  }

  public double getDepositValue() {
    return depositValue;
  }

  public void setDepositValue(double depositValue) {
    this.depositValue = depositValue;
  }

  public double balance(double depositValue) {
    return balance += depositValue + initialDeposit;
  }

  public double balance(double depositValue, double withdrawValue) {
    return balance += depositValue + initialDeposit - withdraw(withdrawValue);
  }

  public double withdraw(double withdrawValue) {
    double total = 0;
    total = (balance + withdrawValue) + 5;
    return total;
  }

  public String showAccountData() {
    return "\nAccount data:\nAccount " + accountNumber + ", Holder: " + ownerName + ", Balance: $"
        + String.format("%.2f", initialDeposit);
  }

  public String showUpdatedData() {
    return "Updated data:\nAccount " + accountNumber + ", Holder: " + ownerName + ", Balance: $"
        + String.format("%.2f", balance(depositValue));
  }

  public String showUpdatedData(double withdrawValue) {
    return "Updated data:\nAccount " + accountNumber + ", Holder: " + ownerName + ", Balance: $"
        + String.format("%.2f", balance(depositValue, withdrawValue));
  }
}
