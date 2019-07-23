package cup.example;

import java.io.FileReader;
import java_cup.runtime.*;


public class Driver {
  public static void main(String[] args) throws Exception {
    Scanner scanner = new Scanner (new FileReader("input.txt"));
    while (true) {
      Symbol sym = scanner.next_token();
      if (sym.getType() == Symbol.EOF)
        break;
      System.out.println(sym.toString());
 
        }
    }
}