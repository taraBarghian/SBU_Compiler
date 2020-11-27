import java.io.*;
import java_cup.runtime.*;
%%

%public
%class Scanner
%cup
%unicode
%line
%column
%char

//%function next_token()
%type Symbol // instead of int

%{

public Symbol token(int tokenType){
     // System.out.println(yytext());
      return new Symbol (tokenType );
}

%}


/* *********** basic *********** */

NextLine = [\r|\n|\r\n]
AnyThing = [^\r|\n|\r\n]
Space = [ ]
WhiteSpace=[\s]
Tab = \t
Underscore = "_"


/* *********** rever *********** */

KeyWords = void | int | double | bool | string | class | interface |  null |  this |  extends |  implements | for |  while |  if |  else |  return |  break |  continue |  new |  NewArray |  Print |  ReadInteger |  ReadLine |  dtoi |  itod |  btoi |  itob |  private |  protected |  public

/* *********** string ************* */

String = "\""[^\r|\n|\r\n|\"]*"\""

/* *********** numbers  *********** */

Sign = [\-\+]? //optional
DecimalInteger = [\d]+
HexaDecimal = [0][xX][0-9a-fA-F]+
IntegerNumber ={DecimalInteger} | {HexaDecimal}

DoubleNumber = {Sign} ( ([\d]*\.[\d]+ ) | ([\d]+\.[\d]*) )
//FloatNumber = {DoubleNumber}[F]

Ex = [eE]
base = ([\d]+\.[\d]*)
ScientificFloat ={base}{Ex}{DecimalInteger}
RealNumber =  {DoubleNumber} | {ScientificFloat}


/* *********** comments *********** */

SingleLine = "//"{AnyThing}*{NextLine}
MultiLine = "/*"~"*/"
Comments = {SingleLine}| {MultiLine}

/** *********** Identifiers *********** **/

Identifiers = [a-zA-Z][\w]*

/* other symbols */

/** boolean */
Booleans = true  | false

%%

<YYINITIAL>{
    "extends" 	         {return token(sym.EXTENDS);}
    "void" 		         {return token(sym.VOID);}
    "implements"     	 {return token(sym.IMPLEMENTS);}
    "private" 	       	 {return token(sym.PRIVATE);}
    "class" 	         {return token(sym.CLASS);}
    "protected"      	 {return token(sym.PROTECTED);}
    "public" 	       	 {return token(sym.PUBLIC);}
    "interface"          {return token(sym.INTERFACE);}
    "if" 		         {return token(sym.IF);}
    "else" 		         {return token(sym.ELSE);}
    "while" 	         {return token(sym.WHILE);}
    "for" 		         {return token(sym.FOR);}
    "return" 	         {return token(sym.RETURN);}
    "break" 	         {return token(sym.BREAK);}
    "continue" 	         {return token(sym.CONTINUE);}
    "print" 	         {return token(sym.PRINT);}
    "new" 		         {return token(sym.NEW);}
     "this" 			 {return token(sym.THIS);}


     "int" 			     {return token(sym.INT);}
     "double" 			 {return token(sym.DOUBLE);}
     "bool" 			 {return token(sym.BOOL);}
     "string" 			 {return token(sym.STRING);}
     "null"              {return token(sym.NULL);}



     "ReadInteger()"     {return token(sym.ReadInteger);}
     "readLine()"        {return token(sym.readLine);}
     "NewArray()"        {return token(sym.NewArray);}
     "itod()"            {return token(sym.itod);}
     "dtoi()"            {return token(sym.dtoi);}
     "itob()"            {return token(sym.itob);}
     "btoi()"            {return token(sym.btoi);}




    {Booleans}        { return token(sym.boolConstant);}
    {Identifiers}     { return token(sym.IDENT); }
    {IntegerNumber}   { return token(sym.intConstant); }
    {RealNumber}      { return token(sym.doubleConstant); }


     {String}         { return token(sym.stringConstant);}



    {NextLine}       {}
    {Space}          {}


// library function


// op
 "=="       {return token(sym.EQEQ);}
 "."        {return token(sym.DOT);}
  "!="      {return token(sym.NOTEQ);}
  ","       {return token(sym.COMA);}
  "<="      {return token(sym.LTEQ);}
  ":"       {return token(sym.COLON);}
  "<"       {return token(sym.LT);}
  ";"       {return token(sym.SEMI);}
  ">"       {return token(sym.GT);}
   "["      {return token(sym.BRACKETS_OPEN);}
   "]"      {return token(sym.BRACKETS_CLOSE);}
   "[]"     {return token(sym.BOTH_BRACKETS);}
   ">="     {return token(sym.GTEQ);}
   "+"      {return token(sym.PLUS);}
   "="      {return token(sym.EQ);}
   "-"      {return token(sym.MINUS);}
   "&&"     {return token(sym.AND);}
   "/"      {return token(sym.DEVIDE);}
   "||"     {return token(sym.OR);}
   "%"      {return token(sym.MOD);}
   "*"      {return token(sym.TIMES);}
   "("      {return token(sym.PARENTHESES_OPEN);}
   ")"      {return token(sym.PARENTHESES_CLOSE);}
  // "()"     {return token(sym.BOTH_PARENTHESES);}
   "!"      {return token(sym.NOT);}
   "{"      {return token(sym.BRACES_OPEN);}
   "}"      {return token(sym.BRACES_CLOSE);}
   //"{}"      {return token(sym.BOTH_BRACES);}


}

