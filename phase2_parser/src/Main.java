import java.io.File;
import java.io.FileReader;

public class Main {
    public static void main(String[] args) throws Exception {

        FileReader fr = new FileReader(new File("src/inp.txt"));
        Scanner scanner = new Scanner(fr);

        parser ps = new parser(scanner);

        try {
            ps.parse();
            System.out.println("OK");
        }catch (Exception e){
            System.out.println("Syntax Error");
           // System.out.println(e.getMessage());
        }
    }

}
