import java.io.*;

public class Main {
    public static void parseAndWriteOutput(Parser parser, String outputFilePath) throws IOException {




            File myObj = new File(outputFilePath);
            myObj.createNewFile();
            FileWriter myWriter = new FileWriter(outputFilePath);

            try {
                parser.parse();
                myWriter.write("Syntax is correct!");
                myWriter.close();

            } catch (Exception e) {
                myWriter.write("Syntax is wrong!");
                System.out.println(e.toString());
                myWriter.close();
            }

    }

    public static void main(String[] args) throws IOException {
        String inputCoolFilePath = "";
        String outputFilePath = "";
        String tablePath = "";
        if (args.length >= 6) {
            for (int i = 0; i < args.length; i++) {
                if (args[i].equals("--input")) {
                    inputCoolFilePath = args[i + 1];
                }
                if (args[i].equals("--output")) {
                    outputFilePath = args[i + 1];
                }
                if (args[i].equals("--table")) {
                    tablePath = args[i + 1];
                }
            }
        } else {
            System.out.println(
                    "Run like bellow:\njava <javaClassFile> --input <inputCoolFilePath> --output <outputFilePath> --table <tablePath>");
            return;
        }
        // inputCoolFilePath can be like this: ./test/test1.cool
        // outputFilePath can be like this: ./out/test1.txt
        // tablePath can be like this: ./src/table.npt

        // Make a new instance of your parser that reads scanner tokens
        // and then call "parse" method of your parser

        // write the result of parsing in the outputFilePath.
        // if the syntax is correct you should write "Syntax is correct!"
        // and if the syntax is wrong, you should write "Syntax is wrong!" in
        // outputFilePath.
        Scanner scanner = new Scanner(new FileReader(inputCoolFilePath));
        CodeGeneratorImpl codeGen = new CodeGeneratorImpl();
        Parser parser = new Parser(scanner, codeGen, tablePath);
        parseAndWriteOutput(parser, outputFilePath);

    }
}