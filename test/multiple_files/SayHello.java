import java.util.Scanner;

public class SayHello {
  public static void main(String[] args) {

    Scanner scanner = new Scanner(System.in);

    System.out.print("Enter your name: ");
    String name = scanner.nextLine();

    sayHello(name);

  }

  public static void sayHello(String name) {
    System.out.println("Hello " + name + "!"); 
  }
}
