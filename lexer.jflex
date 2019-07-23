package cup.example;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;
import java.lang.*;
import java.io.InputStreamReader;

%%

%class Scanner
%unicode
%line
%column
%function next_token
%type Symbol

%{
 StringBuilder lexeme = new StringBuilder();

  private Symbol generateToken(int type){
    return new Symbol(type, yyline+1, yycolumn+1);
  }

  private Symbol generateToken(int type, Object value){
    return new Symbol(type, yyline+1, yycolumn+1, value);
  }
%}

Newline   = \r | \n | \r\n
Whitespace = [ \t\f] | {Newline}


/* comments */
Comment = {TraditionalComment} | {EndOfLineComment}
TraditionalComment = "/*" {CommentContent} \*+ "/*"
EndOfLineComment = "//" [^\r\n]* {CommentContent}  {Newline}
CommentContent =  ( [^*] | \*+[^*/] )*

Identifier = ([:jletter:] | "_" ) ([:jletterdigit:] | [:jletter:] | "_" )*
Dec = 0|[1-9][0-9]* /*i numeri sono o 0 oppure una cifra da 1 a 9 eventualmente seguita da altre cifre*/
Dou = (0 | [1-9][0-9]*)\.[0-9]+

/*String literal*/
StringLiteral = [^\r\n\"\\]


%eofval{
    return symbolFactory.newSymbol("EOF",sym.EOF);
%eofval}


%state STRING

%%  

<YYINITIAL> {
	{Whitespace} {		}
	{Comment} { }		

//keywords
  "if"		{return generateToken(Symbol.IF);}
  "then"	{return generateToken(Symbol.THEN);}
  "else"	{return generateToken(Symbol.ELSE);}
  "for"		{return generateToken(Symbol.FOR);}
  "while"	{return generateToken(Symbol.WHILE);}
 
//separator
  ";"       {return generateToken(Symbol.SEMI);}
  "("		{return generateToken(Symbol.LPAR);}
  ")"		{return generateToken(Symbol.RPAR);}
  "["		{return generateToken(Symbol.LBRACE);}
  "]"		{return generateToken(Symbol.RBRACE);}
  "{"		{return generateToken(Symbol.LBRACK);}
  "}"		{return generateToken(Symbol.RBRACK);}
  "."		{return generateToken(Symbol.DOT);}

//operator
  "+"		{return generateToken(Symbol.PLUS);}
  "-"		{return generateToken(Symbol.MINUS);}
  "*"		{return generateToken(Symbol.MULTIPLE);}
  "/"		{return generateToken(Symbol.DIVIDE);}
  "<"		{return generateToken(Symbol.MINOR);}
  ">"		{return generateToken(Symbol.MAJOR);}
  "="		{return generateToken(Symbol.EQ);}
  "=="		{return generateToken(Symbol.EQEQ);}
  "<="		{return generateToken(Symbol.LEQ);}
  ">="		{return generateToken(Symbol.REQ);}
  "!="		{return generateToken(Symbol.NOT);}
  "&&"		{return generateToken(Symbol.AND);}
  "||"		{return generateToken(Symbol.OR);}
  
  {Identifier} {return generateToken(Symbol.Identifier, yytext());}
  {Dec} { return generateToken(Symbol.Dec, Integer.parseInt(yytext()));}
  {Dou} { return generateToken(Symbol.Dou, Double.parseDouble(yytext()));}
  
  /*When found " start state string*/
  \" {yybegin(STRING); lexeme.setLength(0); }

}

/*Handle String state*/
<STRING> {
\" { yybegin(YYINITIAL); return generateToken(Symbol.STRING_LITERAL, lexeme.toString()); }
/* escape sequences */
  {StringLiteral}+ { lexeme.append( yytext()); }
  "\\b" 	{ lexeme.append( '\b' ); }
  "\\t" 	{ lexeme.append( '\t' ); }
  "\\n" 	{ lexeme.append( '\n' ); }
  "\\f" 	{ lexeme.append( '\f' ); }
  "\\r" 	{ lexeme.append( '\r' ); }
  "\\\"" 	{ lexeme.append( '\"' ); }
  "\\'" 	{ lexeme.append( '\'' ); }
  "\\\\" 	{ lexeme.append( '\\' ); }


// error fallback

 \\. { throw new RuntimeException("Illegal escape sequence \""+yytext()+"\"");	}
  {Newline} { throw new RuntimeException("Unterminated string at end of line"); }
  }
  <<EOF>>  { return generateToken(Symbol.EOF); }
