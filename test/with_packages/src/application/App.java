package application;

import java.util.Scanner;
import entities.BankAccount;

public class App {
  public static void main(String[] args) {

    Scanner scanner = new Scanner(System.in);

    System.out.print("Enter account number: ");
    long accountNumber = scanner.nextLong();

    scanner.nextLine();
    System.out.print("Enter account holder: ");
    String ownerName = scanner.nextLine();

    BankAccount account = null;

    System.out.println("Is there an initial deposit value (y/n)?");
    String choice = scanner.next();

    if (choice.equalsIgnoreCase("y") || choice.equalsIgnoreCase("yes")) {
      System.out.print("Enter initial deposit: ");
      double initialDeposit = scanner.nextDouble();
      account = new BankAccount(accountNumber, ownerName, initialDeposit);
    } else {
      account = new BankAccount(accountNumber, ownerName);
    }

    if (account != null) {
      System.out.println(account.showAccountData());
      System.out.println();
    } else {
      System.out.println("Error creating account.");
    }

    System.out.println("Enter deposit value");
    double depositValue = scanner.nextDouble();
    account.setDepositValue(depositValue);

    System.out.println(account.showUpdatedData());

    System.out.print("Enter a withdraw value: ");
    double withdrawValue = scanner.nextDouble();

    System.out.println(account.showUpdatedData(withdrawValue));

    scanner.close();

  }
}
