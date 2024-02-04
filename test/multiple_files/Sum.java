import java.util.Scanner;

public class Sum {
  public static void main(String[] args) {
    
    Scanner scanner = new Scanner(System.in);

    System.out.print("Enter first integer: ");
    int number1 = scanner.nextInt();

    System.out.print("Enter second integer: ");
    int number2 = scanner.nextInt();

    int sum = number1 + number2;

    System.out.println("Sum is " + sum);

    scanner.close();

  }
}
