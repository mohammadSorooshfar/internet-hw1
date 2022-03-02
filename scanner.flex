import java.io.*;
// user code section
// scanner class
//
%%
// opttions
%class Scanner
%public
%unicode
%line
%column
%function next
%implements Lexical
%type Symbol

//%standardalone


%{
    // moteghayer haye dakhel class Scanner
  StringBuffer string = new StringBuffer();  
   public String nextToken(){
      try{
          Symbol current=next();
          return current== null ? "$" : current.getValue().toString();
      }catch(Exception e){
          e.printStackTrace();
          return null;
      }
  }
  private String html = "<html>\n" +
            "<body style=\"background-color:black;\">";

  public Symbol currentSymbol;
  private Symbol symbol(String tokenName, Object value) {
    return new Symbol(tokenName,value);
  }

  public void end() {
    html += "</body>\n" +
                            "</html>";
    try {
        File file = new File("src/tmp.html");
        FileWriter f = new FileWriter("C:/Users/Lenovo/IdeaProjects/comp/src/tmp.html");
          f.write(html);
          f.close();
        }catch (IOException e) {
          System.out.println("ERROR");
        }
  
  }
  private void IdentifierE() {
      html += "<l style=\"color:#FFFFFF; \">" + yytext() +"</l>";
  }
            
  private void keyword() {
      html += "<l style=\"color:#FC618D; font-weight : bold;\">" + yytext() +"</l>";
  }

  private void integerN() {
      html += "<l style=\"color:#F59762;\">" + yytext() +"</l>";
  }

  private void realNum() {
      html += "<l style=\"color:#F59762; font-style:italic;\">" + "<i>" + yytext() + "</i>" +"</l>";
  }

  private void stringS() {
      html += "<l style=\"color:#FCE566;\">" + string +"</l>";
  }

  private void comment() {
      html += "<l style=\"color:#69676C;\">" + yytext()+"</l>";
  }

  private void operator() {
      html += "<l style=\"color:#00FFFF;\">" + yytext()+"</l>";
  }

  private void undefindToken() {
      html += "<l style=\"color:red;\">" + yytext()+"</l>";
  }

%}

LineTerminator = \r|\n|\r\n
SPACE = " "
InputCharacter = [^\r\n]
//Tab = \t

 // comments  
CStyleComment = "/*"~"*/"
OneLineComment = "//" {InputCharacter}* {LineTerminator}
Comment = {CStyleComment}|{OneLineComment}
//
Letter = [A-Za-z]
Digit = [0-9]
Underline = "_"
Identifier = {Letter} ({Underline} | {Letter} | {Digit}) {0, 30}


sign=[\-]?
DecimalInteger={sign}[0-9]+
Hexadecimal={sign}[0][xX][0-9a-fAF]+
RealNumbers={sign}[0-9]+"."[0-9]*
ScientificNotation={sign}[0-9]+"."[0-9]*[e|E][\+|\-][0-9]+
///////////////////////////////////////////////////////////////////////////////
//  Operators_ Punctuation
Operators_Punctuation="*"|"+="|"*+"|"++"|"<"|">"|"!="|"<-"|"&&"|"&"|"“"|"!"|"["|"("|"{"|"/"|"-="|"/="|"--"|"<="|"=="|"%"|"||"|"|"|"^"|"."|";"|"]"|")"|"}"|"+"|"-"|"="
colon=","
start_string="\""
comma="'"
//////////////////////////////////////////////////////////////////////////////
%state STRING
%%
// Reserved Keywords 
<YYINITIAL> {
   "let"             {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "void"            {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "int"             {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "real"            {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "bool"            {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "string"          {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "static"          {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "class"           {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "for"             {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "rof"             {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "loop"            {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "pool"            {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "while"           {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "break"           {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "continue"        {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "if"              {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "fi"              {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "else"            {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "then"            {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "new"             {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "Array"           {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "return"          {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "in_string"       {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "in_int"         {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "print"           {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
   "len"             {keyword();yybegin(YYINITIAL); return symbol("keyword",yytext()); }
    {DecimalInteger}   {integerN();yybegin(YYINITIAL); return symbol("intc",yytext()); }
    {Hexadecimal}     {integerN();yybegin(YYINITIAL); return symbol("intc",yytext()); }
    {RealNumbers}       { realNum();yybegin(YYINITIAL); return symbol("realc",yytext()); }       
    {ScientificNotation}    { realNum();yybegin(YYINITIAL); return symbol("realc",yytext()); }   
    {Comment}               { comment(); html += "<l style=\"color:red;\"> <br> </l>"; return symbol("comment",yytext()); }
    {Identifier}            { IdentifierE(); yybegin(YYINITIAL); return symbol("id",yytext()); }
    {Operators_Punctuation}  {operator(); yybegin(YYINITIAL); return symbol("operator",yytext()); }
	{SPACE}     { html += "<l> &nbsp </l>"; return symbol("SPACE",yytext()); }
    {LineTerminator}    {html += "<l> <br> </l>"; return symbol("LineTerminator",yytext()); }
    {start_string}      { string.setLength(0); yybegin(STRING); }
    {comma}             {operator(); yybegin(YYINITIAL); return symbol("comma",yytext());}
    {colon}             {operator(); yybegin(YYINITIAL); return symbol("colon",yytext());}
}

// special char
<STRING> {

\"                             {yybegin(YYINITIAL);}
                    
    [^\n\r\"\\]+                   { string.append( yytext() ); html += "<l style=\"color:#FCE566;\">" +"\"" +yytext() + "\""+"</l>";return symbol("stringc",yytext());}
    "\\t"                            { string.append("\\t"); html += "<l style=\"color:#EE82EE; font-style:italic;\">" + "<i>" +"\\t"+ "</i>" +"</l>";}
    "\\n"                            { string.append("\n"); html += "<l style=\"color:#EE82EE; font-style:italic;\">" + "<i>" +"\\n"+ "</i>" +"</l>";}
    "\\r"                            { string.append("\r"); html += "<l style=\"color:#EE82EE; font-style:italic;\">" + "<i>" +"\\r"+ "</i>" +"</l>";}
    "\\\""                         {string.append("\"");html  +="<l style=\"color:#EE82EE; font-style:italic;\">"  + "<i>" +"\\\""+ "</i>" +"</l>";}
    "\\\'"                         { string.append("\'"); html += "<l style=\"color:#EE82EE; font-style:italic;\">" + "<i>" + "\'" + "</i>" +"</l>";}
    "\\\\"                          { string.append("\\\\"); html += "<l style=\"color:#EE82EE; font-style:italic;\">" + "<i>" + "\\\\" + "</i>" +"</l>";}
}

 /* error fallback */
  [^]                              { undefindToken(); return symbol(null,null);}
