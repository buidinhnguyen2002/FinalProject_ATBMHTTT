package entity;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.security.DigestInputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class SHA {
    public static String SHA_1 = "SHA-1";
    public String SHA_224 = "SHA-224";
    public String SHA_256 = "SHA-256";
    public String SHA_384 = "SHA-384";
    public String SHA_512_224 = "SHA-512/224";
    public static String[] modes = {"SHA-1", "SHA-256", "SHA-384", "SHA-512/224"};
    private static String algorithm = "SHA-256";
    private String modeAlgorithm;
    public SHA(String algorithm) {
        this.algorithm = algorithm;
    }
    public boolean checkElectronicSignature(String file,String hashCode){
        boolean result = false;
        try {
            result = hashFile(file).equals(hashCode);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return result;
    }
    public static String hashText(String input){
        try{
            MessageDigest md = MessageDigest.getInstance(algorithm);
            byte[] messageDigest = md.digest(input.getBytes());
            BigInteger number = new BigInteger(1, messageDigest);
            String hashText = number.toString(16);
            return hashText;
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
    public String hashFile(String file) throws NoSuchAlgorithmException, IOException {
        MessageDigest digest = MessageDigest.getInstance(algorithm);
        InputStream is = new BufferedInputStream(new FileInputStream(file));
        DigestInputStream dis = new DigestInputStream(is,digest);
        byte[] buffer = new byte[1024];
        int read;
        do{
            read = dis.read(buffer);
        }while (read != -1);
        BigInteger number = new BigInteger(1, dis.getMessageDigest().digest());
        return number.toString(16);
    }
    public static void main(String[] args) throws NoSuchAlgorithmException, IOException {
//        SHA sha = new SHA();
//        String shaHashValue = sha.hash("Khoa CNTT", SHA_1);
//        String shaHashFileValue = sha.hashFile("D:\\Storage NLU data\\An toan bao mat he thong thong tin\\SLide\\6. Ham bam.pdf", SHA_1);
//        System.out.println(shaHashValue);
//        System.out.println("Hash file: " + shaHashFileValue);
    }
}
