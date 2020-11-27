package lexical_analyzer;

public class Symbol {

    public StringBuilder stringBuilder ;
    //public int line;
    //public int column;
    public SymbolType symbolType;

    public Symbol(StringBuilder stringBuilder, SymbolType tokenType) {
        this.stringBuilder = stringBuilder;
       // this.line = line;
        //this.column = column;
        this.symbolType =tokenType;
    }

    @Override
    public String toString() {
        return stringBuilder.toString();
    }
}

