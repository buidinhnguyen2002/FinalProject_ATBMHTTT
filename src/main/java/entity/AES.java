package entity;

import javax.crypto.*;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.*;
import java.security.*;
import java.util.Base64;

public class AES {
    private SecretKey key;
    public static String[] modes = {"ECB", "CBC", "CFB", "OFB"};
    private String modeAlgorithm;
    private String defaultKey;
    public AES(int keySize) throws NoSuchAlgorithmException {
        defaultKey = "TnG/nz0PfGOp9izSf0ycNEf7z1iaLTh/2uPrslj8GDg=";
        modeAlgorithm = "ECB";
//        key = creteKey(keySize);
    }

    public AES( String key, String modeAlgorithm) throws UnsupportedEncodingException {
        SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
        this.key = secretKeySpec;
        this.modeAlgorithm = modeAlgorithm;
    }
    public AES() {
    }
    public static String[] keySizes = {"128", "192", "256"};
    public SecretKey creteKey(int keySize) throws NoSuchAlgorithmException {
        KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
        keyGenerator.init(keySize);
        key = keyGenerator.generateKey();
        System.out.println(key.getEncoded().length);
        return key;
    }

    public String encryptAES(String plaintext, String key) throws NoSuchPaddingException, NoSuchAlgorithmException, NoSuchProviderException, UnsupportedEncodingException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS7Padding", "BC");
        byte[] plaintextBytes = plaintext.getBytes("UTF-8");
        SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
        cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec);
        byte[] cipherText = cipher.doFinal(plaintextBytes);
        return Base64.getEncoder().encodeToString(cipherText);
    }
    public String encryptAES(String plaintext, String key, String iv) throws NoSuchPaddingException, NoSuchAlgorithmException, NoSuchProviderException, UnsupportedEncodingException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException, InvalidAlgorithmParameterException {
        Cipher cipher = Cipher.getInstance("AES/"+modeAlgorithm+"/PKCS7Padding", "BC");
        byte[] plaintextBytes = plaintext.getBytes("UTF-8");
        SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
        if(modeAlgorithm.equals("ECB")){
            cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec);
        }else{
            IvParameterSpec ivParameterSpec = new IvParameterSpec(iv.getBytes("UTF-8"));
            cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, ivParameterSpec);
        }
        byte[] cipherText = cipher.doFinal(plaintextBytes);
        return Base64.getEncoder().encodeToString(cipherText);
    }
    public void encryptAESFile(String sourceFile, String destFile, String iv) throws IOException, NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException, NoSuchProviderException, InvalidAlgorithmParameterException {
        if(key == null) throw new FileNotFoundException("Key not found");
        File file = new File(sourceFile);
        if(file.isFile()){
            Cipher cipher = Cipher.getInstance("AES/"+modeAlgorithm+"/PKCS7Padding");
            if(modeAlgorithm.equals("ECB")){
                cipher.init(Cipher.ENCRYPT_MODE, key);
            }else{
                IvParameterSpec ivParameterSpec = new IvParameterSpec(iv.getBytes("UTF-8"));
                cipher.init(Cipher.ENCRYPT_MODE, key, ivParameterSpec);
            }
            FileInputStream fis = new FileInputStream(file);
            FileOutputStream fos = new FileOutputStream(destFile);
            BufferedInputStream bis = new BufferedInputStream(fis);
            BufferedOutputStream bos = new BufferedOutputStream(fos);
            byte[] input = new byte[64];
            int bytesRead;
            while((bytesRead = bis.read(input)) != -1){
                byte[] output= cipher.update(input, 0, bytesRead);
                if(output != null) bos.write(output);
            }
            byte[] output = cipher.doFinal();
            if(output != null) bos.write(output);
            bis.close();
            bos.flush();
            bos.close();
            fis.close();
            fos.close();
            System.out.println("Encrypted");
        }else{
            System.out.println("This is not a file");
        }
    }

    public String decryptAES(String text, String key) throws NoSuchPaddingException, NoSuchAlgorithmException, NoSuchProviderException, UnsupportedEncodingException, IllegalBlockSizeException, BadPaddingException, InvalidKeyException {
        byte[] encryptDataBytes = Base64.getDecoder().decode(text);
        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS7Padding", "BC");
        SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
        cipher.init(Cipher.DECRYPT_MODE, secretKeySpec);
        byte[] decryptedBytes = cipher.doFinal(encryptDataBytes);
        return new String(decryptedBytes, "UTF-8");
    }

    public String decryptAESText(String text, String key, String iv) throws NoSuchPaddingException, NoSuchAlgorithmException, NoSuchProviderException, UnsupportedEncodingException, IllegalBlockSizeException, BadPaddingException, InvalidKeyException, InvalidAlgorithmParameterException {
        byte[] encryptDataBytes = Base64.getDecoder().decode(text);
        Cipher cipher = Cipher.getInstance("AES/"+modeAlgorithm+"/PKCS7Padding", "BC");
        SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
        if(modeAlgorithm.equals("ECB")){
            cipher.init(Cipher.DECRYPT_MODE, secretKeySpec);
        }else{
            IvParameterSpec ivParameterSpec = new IvParameterSpec(iv.getBytes("UTF-8"));
            cipher.init(Cipher.DECRYPT_MODE, secretKeySpec, ivParameterSpec);
        }
        byte[] decryptedBytes = cipher.doFinal(encryptDataBytes);
        return new String(decryptedBytes, "UTF-8");
    }
    public String decryptAES(String text, String key, String iv) throws NoSuchPaddingException, NoSuchAlgorithmException, NoSuchProviderException, UnsupportedEncodingException, IllegalBlockSizeException, BadPaddingException, InvalidKeyException, InvalidAlgorithmParameterException {
        byte[] encryptDataBytes = Base64.getDecoder().decode(text);
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS7Padding");
        SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
        IvParameterSpec ivParameterSpec = new IvParameterSpec(iv.getBytes("UTF-8"));
        cipher.init(Cipher.DECRYPT_MODE, secretKeySpec, ivParameterSpec);
        byte[] decryptedBytes = cipher.doFinal(encryptDataBytes);
        return new String(decryptedBytes, "UTF-8");
    }
    public void decryptAESFile(String sourceFile, String destFile, String iv) throws IOException, NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException, NoSuchProviderException, InvalidAlgorithmParameterException {
        if(key == null) throw new FileNotFoundException("Key not found");
        File file = new File(sourceFile);
        if(file.isFile()){
            Cipher cipher = Cipher.getInstance("AES/"+modeAlgorithm+"/PKCS7Padding");
            if(modeAlgorithm.equals("ECB")){
                cipher.init(Cipher.DECRYPT_MODE, key);
            }else{
                IvParameterSpec ivParameterSpec = new IvParameterSpec(iv.getBytes("UTF-8"));
                cipher.init(Cipher.DECRYPT_MODE, key, ivParameterSpec);
            }
            FileInputStream fis = new FileInputStream(file);
            FileOutputStream fos = new FileOutputStream(new File(destFile));
            BufferedInputStream bis = new BufferedInputStream(fis);
            BufferedOutputStream bos = new BufferedOutputStream(fos);
            byte[] input = new byte[64];
            int readByte = 0;
            while((readByte = bis.read(input)) != -1){
                byte[] output= cipher.update(input, 0, readByte);
                if(output != null) bos.write(output);
            }
            byte[] output = cipher.doFinal();
            if(output != null) bos.write(output);
            bis.close();
            bos.flush();
            bos.close();
            fis.close();
            fos.close();
            System.out.println("Decrypted");
        }else{
            System.out.println("This is not a file");
        }
    }
    public String exportKey(){
        return Base64.getEncoder().encodeToString(key.getEncoded());
    }

    public SecretKey getKey() {
        return key;
    }

    public static void main(String[] args) throws Exception {
//        AES aes = new AES();
//
//        // Khóa AES (128-bit key)
//        String secretKey = "asdfghjklzxcvbnm"; // Thay thế bằng khóa thực tế
//
//        // Dữ liệu cần mã hóa
//        String plaintext = "Hello, AES!";
//        String iv = "asdfghjklzxcvbnm";
//        // Mã hóa dữ liệu
//        String encryptedData = aes.encryptAES(plaintext, secretKey);
//        System.out.println("Encrypted: " + aes.encryptAES(plaintext, secretKey));
//
//        String encryptedDataCBC = aes.encryptAES(plaintext, secretKey, iv);
//        System.out.println("Encrypted With CBC: " + encryptedDataCBC);
//        // Giải mã dữ liệu
//        String decryptedData = aes.decryptAES(encryptedData, secretKey);
//        System.out.println("Decrypted: " + decryptedData);
//        String decryptedDataCBC = aes.decryptAES(encryptedDataCBC, secretKey, iv);
//        System.out.println("Decrypted CBC: " + decryptedDataCBC);

        AES aes = new AES(256);
        System.out.println(aes.exportKey());
    }
}
