import java.util.Scanner;

public class Greater {
  public static void main(String[] args) {
    
    Scanner scanner = new Scanner(System.in);

    System.out.println("This program finds the greater of 10 numbers");

    int number = 0;

    int greater = 0;
    for (int i = 0; i < 10; i++) {
      System.out.print("Enter the " + (i + 1) + "º number: ");
      number = scanner.nextInt();

      if (number >= greater) {
        greater = number;
      }
    }

    System.out.println("The greater number is " + greater);

    scanner.close();

  }
}
