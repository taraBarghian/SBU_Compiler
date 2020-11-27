package jflexion;
import lexical_analyzer.*;

%%

%public
%class Lexer
//%cup
//%standalone
%unicode
%line
%column

%function next // yylex
%type Symbol // instead of int

%state STRING
%state CHARACTER

/* *********** basic *********** */

NextLine = [\r|\n|\r\n]
AnyThing = [^\r|\n|\r\n]
Space = [ ]
WhiteSpace=[\s]
Tab = \t
Underscore = "_"


/* *********** rever *********** */

KeyWords = void | int | double | bool | string | class | interface |  null |  this |  extends |  implements | for |  while |  if |  else |  return |  break |  continue |  new |  NewArray |  Print |  ReadInteger |  ReadLine |  dtoi |  itod |  btoi |  itob |  private |  protected |  public



/* *********** numbers  *********** */

Sign = [\-\+]? //optional
DecimalInteger = {Sign}[\d]+
HexaDecimal = {Sign}[0][xX][0-9a-fA-F]+
IntegerNumber ={DecimalInteger} | {HexaDecimal}

DoubleNumber = {Sign} ( ([\d]*\.[\d]+ ) | ([\d]+\.[\d]*) )
//FloatNumber = {DoubleNumber}[F]

Ex = [eE]
base = ([\d]+\.[\d]*)
ScientificFloat ={base}{Ex}{DecimalInteger}
RealNumber =  {DoubleNumber} | {ScientificFloat}


/* *********** string & char *********** */


/* *********** comments *********** */

SingleLine = "//"{AnyThing}*{NextLine}
MultiLine = "/*"~"*/"
Comments = {SingleLine}| {MultiLine}

/** *********** Identifiers *********** **/

Identifiers = [a-zA-Z][\w]*

/* other symbols */
OtherSymbols = == | "." | "!=" | "," |"<=" |":" |"<" |";" |">" |  "[" | "]" |  ">=" | "+" | "=" | "-"  | "&&" |"/" |"||" |"%" | "*" | "(" | ")" | "!"

/** boolean */
Booleans = true  | false

%%

<YYINITIAL>{
    {KeyWords}        { return new Symbol(new StringBuilder(yytext()), SymbolType.ReservedKeyWords);}
    {Booleans}        { return new Symbol(new StringBuilder(yytext()), SymbolType.Boolean);}

    {Identifiers}     { return new Symbol(new StringBuilder(yytext()), SymbolType.Identifiers); }

    {IntegerNumber}   { return new Symbol(new StringBuilder(yytext()), SymbolType.IntegerNumbers ); }
    {RealNumber}      { return new Symbol(new StringBuilder(yytext()), SymbolType.RealNumbers ); }


      	"\""          { yybegin( STRING ); return new Symbol( new StringBuilder(yytext()), SymbolType.StringAndChar ); }
      	"\'"          { yybegin( CHARACTER ); return new Symbol( new StringBuilder("\'"), SymbolType.StringAndChar); }


    {Comments}        { return new Symbol( new StringBuilder(yytext()), SymbolType.Comment); }

   // {Tab}                      { return new Symbol( yytext(), TokenType.TAB, yyline, yycolumn ); }
    //{WhiteSpace}     { return new Symbol( yytext(), TokenType.SPACE, yyline, yycolumn ); }

     {NextLine}       {return new Symbol( new StringBuilder("\n"), SymbolType.NextLine); }
      {Space}         {return new Symbol( new StringBuilder(yytext()), SymbolType.Space); }
      {OtherSymbols} { return new Symbol(  new StringBuilder(yytext()), SymbolType.OtherSymbols ); }
      [^]             { return new Symbol(  new StringBuilder(yytext()), SymbolType.OtherSymbols ); }
}


<STRING> {

    "\""       { yybegin( YYINITIAL ); return new Symbol(  new StringBuilder(yytext()), SymbolType.StringAndChar ); }
      	.           { return new Symbol( new StringBuilder(yytext()), SymbolType.StringAndChar ); }

	"\\n"      { return new Symbol( new StringBuilder(yytext()), SymbolType.SpecialChar); }
	"\\t"      { return new Symbol( new StringBuilder(yytext()), SymbolType.SpecialChar); }
	"\\v"      { return new Symbol( new StringBuilder(yytext()), SymbolType.SpecialChar); }
	"\\b"      { return new Symbol( new StringBuilder(yytext()), SymbolType.SpecialChar); }
	"\\r"      { return new Symbol( new StringBuilder(yytext()), SymbolType.SpecialChar); }
	"\\f"      { return new Symbol( new StringBuilder(yytext()), SymbolType.SpecialChar); }
	"\\a"      { return new Symbol( new StringBuilder(yytext()), SymbolType.SpecialChar); }
	"\\?"      { return new Symbol( new StringBuilder(yytext()), SymbolType.SpecialChar); }
	"\\'"      { return new Symbol( new StringBuilder(yytext()), SymbolType.SpecialChar); }
	"\\\""     { return new Symbol( new StringBuilder(yytext()), SymbolType.SpecialChar); }
	"\\0"      { return new Symbol( new StringBuilder(yytext()), SymbolType.SpecialChar); }


}

<CHARACTER>{

    .['] { yybegin( YYINITIAL ); return new Symbol( new StringBuilder(yytext()), SymbolType.StringAndChar ); }

    "\\n'"    { yybegin( YYINITIAL ); return new Symbol( new StringBuilder("\\n'"), SymbolType.SpecialChar); }
	"\\t'"    { yybegin( YYINITIAL ); return new Symbol( new StringBuilder("\\t'"), SymbolType.SpecialChar); }
	"\\v'"    { yybegin( YYINITIAL ); return new Symbol( new StringBuilder("\\v'"), SymbolType.SpecialChar); }
	"\\b'"    { yybegin( YYINITIAL ); return new Symbol( new StringBuilder("\\b'"), SymbolType.SpecialChar); }
	"\\r'"    { yybegin( YYINITIAL ); return new Symbol( new StringBuilder("\\r'"), SymbolType.SpecialChar); }
	"\\f'"    { yybegin( YYINITIAL ); return new Symbol( new StringBuilder("\\f'"), SymbolType.SpecialChar); }
	"\\a'"    { yybegin( YYINITIAL ); return new Symbol( new StringBuilder("\\a'"), SymbolType.SpecialChar); }
	"\\?'"    { yybegin( YYINITIAL ); return new Symbol( new StringBuilder("\\?'"), SymbolType.SpecialChar); }
	"\\\"'"   { yybegin( YYINITIAL ); return new Symbol( new StringBuilder("\\\"'"),SymbolType.SpecialChar); }
	"\\0'"    { yybegin( YYINITIAL ); return new Symbol( new StringBuilder("\\0'"), SymbolType.SpecialChar); }




}