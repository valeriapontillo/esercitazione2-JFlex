package cup.example;

/** CUP generated interface containing symbol constants. */
public class Symbol {
  /* terminals */
  public static final int EOF = 0;
  public static final int IF = 1;
  public static final int THEN = 2;
  public static final int ELSE= 3;
  public static final int FOR= 4;
  public static final int WHILE= 5;
  public static final int SEMI= 6;
  public static final int LPAR= 7;
  public static final int RPAR= 8;
  public static final int LBRACE= 9;
  public static final int RBRACE= 10;
  public static final int LBRACK= 11;
  public static final int RBRACK= 12;
  public static final int DOT= 13;
  public static final int PLUS= 14;
  public static final int MINUS= 15;
  public static final int MULTIPLE= 16;
  public static final int MINOR= 17;
  public static final int MAJOR= 18;
  public static final int EQ= 19;
  public static final int EQEQ= 20;
  public static final int LEQ= 21;
  public static final int REQ= 22;
  public static final int NOT= 23;
  public static final int AND= 24;
  public static final int OR= 25;
  public static final int Identifier=  26;
  public static final int Dec= 27;
  public static final int Dou= 28;
  public static final int STRING_LITERAL= 29;
  public static final int DIVIDE= 30;
  
  public static final String[] terminalNames = new String[] {"EOF","IF","THEN","ELSE","FOR","WHILE",
      "SEMI","LPAR","RPAR","LBRACE","RBRACE","LBRACK","RBRACK","DOT","PLUS","MINUS","MULTIPLE","MINOR",
      "MAJOR","EQ","EQEQ","LEQ","REQ","NOT","AND","OR","Identifier","Dec","Dou","STRING_LITERAL","DIVIDE"};

  private int type;
  private int lineValue;
  private int colValue;
  private Object value;
  private String terminal;


    public Symbol(int type, int line, int col) {
    this.type = type;
    this.lineValue = line;
    this.colValue = col;
    this.value = null;
    this.terminal = terminalNames[type];
  }

  public Symbol(int type, int line, int col, Object value){
    this.type = type;
    this.lineValue = line;
    this.colValue = col; 
    this.value = value;
    this.terminal = terminalNames[type];
  }

  public int getType(){
    return this.type;
  }

  public int getLineValue(){
    return this.lineValue;
  }

  public int getColValue(){
    return this.colValue;
  }

  public Object getValue(){
    return this.value;
  }

  public String getTerminal() {
    return terminal;
  }
  
  @Override
  public String toString(){
    if (this.value == null)
      return String.format("<%s,%d, %d>", this.terminal, this.lineValue, this.colValue);
    return String.format("< %s, %s, %d, %d >", this.value.toString(), this.terminal, this.lineValue,
        this.colValue);
  }
  
}