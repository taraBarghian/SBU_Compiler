package lexical_analyzer;

import jflexion.Lexer;

import java.io.*;

public class main {

    public static void main(String[] args) throws IOException {

        if (args.length != 4) {
            System.err.println("Usage: java main -i <input> -o <output>");
            System.exit(1);
        }

        File inputFile = new File("tests/" + args[1]);
        File outputFile = new File("out/" + args[3]);

        PrintStream outputStream = new PrintStream(outputFile);


        Lexer lexer = new Lexer(new FileReader(inputFile));

        Symbol symbol = lexer.next();
        while (!lexer.yyatEOF()) {
            switch (symbol.symbolType) {
                case Identifiers:
                    outputStream.println("T_ID " + symbol.toString());
                    break;

                case IntegerNumbers:
                    outputStream.println("T_INTLITERAL " + symbol.toString());
                    break;
                case RealNumbers:
                    outputStream.println("T_DOUBLELITERAL " + symbol.toString());
                    break;

                case StringAndChar:
                    outputStream.println("T_STRINGLITERAL " + symbol.toString());
                    break;
                case Boolean:
                    outputStream.println("T_BOOLEANLITERAL " + symbol.toString());
                    break;

                case Comment:
                case SpecialChar:
                case OtherSymbols:
                case ReservedKeyWords:
                    outputStream.println(symbol.toString());
                    break;
                case NextLine:
                case Space:
                    break;

                default:
                    System.out.println("Did Not Handle");
            }

            symbol = lexer.next();

        }

    }


}


