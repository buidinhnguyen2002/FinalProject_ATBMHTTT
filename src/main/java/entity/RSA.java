package entity;
import javax.crypto.*;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

public class RSA {
    public static enum Mode {
        ENCRYPT,
        DECRYPT
    }
    private KeyPair keyPair;
    private PublicKey publicKey;
    private PrivateKey privateKey;
    private Mode mode;
    public static String[] keySizes = {"512", "1024", "2048", "3072", "4096"};
    private int keySize;

    public RSA(int keySize) {
        genKey(keySize);
    }

    public RSA(Mode mode, String key) throws NoSuchAlgorithmException, InvalidKeySpecException, IllegalArgumentException {
        this.mode = mode;
        byte[] keyBytes = Base64.getDecoder().decode(key);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        if (mode == Mode.ENCRYPT) {
            X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(keyBytes);
            publicKey = keyFactory.generatePublic(publicKeySpec);
        } else {
            PKCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(keyBytes);
            privateKey = keyFactory.generatePrivate(privateKeySpec);
        }

    }

    public RSA(Mode mode, String key, int keySize) {
        this.mode = mode;
        byte[] keyBytes = Base64.getDecoder().decode(key);
        this.keySize = keySize;
        try {
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            if (mode == Mode.ENCRYPT) {
                X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(keyBytes);
                publicKey = keyFactory.generatePublic(publicKeySpec);
            } else {
                PKCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(keyBytes);
                privateKey = keyFactory.generatePrivate(privateKeySpec);
            }
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        } catch (InvalidKeySpecException e) {
            throw new RuntimeException(e);
        }
    }

    public String encryptText(String plainText) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
        Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);
        byte[] encryptedBytes = cipher.doFinal(plainText.getBytes(StandardCharsets.UTF_8));
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }


    public String decryptText(String encryptedText) throws NoSuchPaddingException, NoSuchAlgorithmException, NoSuchProviderException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
        Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(encryptedText));
        return new String(decryptedBytes, StandardCharsets.UTF_8);
    }

    public void genKey(int keySize) {
        KeyPairGenerator keyGenerator = null;
        try {
            keyGenerator = KeyPairGenerator.getInstance("RSA");
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        keyGenerator.initialize(keySize);
        keyPair = keyGenerator.generateKeyPair();
        publicKey = keyPair.getPublic();
        privateKey = keyPair.getPrivate();
    }

    public String exportPublicKey() {
        return Base64.getEncoder().encodeToString(publicKey.getEncoded());
    }

    public String exportPrivateKey() {
        return Base64.getEncoder().encodeToString(privateKey.getEncoded());
    }


    public static void main(String[] args) throws NoSuchPaddingException, IllegalBlockSizeException, NoSuchAlgorithmException, BadPaddingException, InvalidKeyException, NoSuchProviderException {
//        RSA rsa = new RSA();
//        Key publicKey = rsa.publicKey;
//        Key privateKey = rsa.privateKey;
//        String plainText = "Hello Nguyên";
//        String encrypt = rsa.encryptText(plainText);
//        System.out.println(encrypt);
//        System.out.println(rsa.decryptText(encrypt, privateKey));
    }
}
