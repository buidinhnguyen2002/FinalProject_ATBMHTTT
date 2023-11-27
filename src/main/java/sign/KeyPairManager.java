package sign;

import context.DBContext;
import org.jdbi.v3.core.Jdbi;

import java.security.*;
import java.util.*;

public class KeyPairManager {

    public static void saveKeyPair(int idAccount, String publicKey) {
        String query = "INSERT INTO key_pairs (idAccount, public_key, creation_date, expiration_date) VALUES (?, ?, CURRENT_TIMESTAMP, ?)";
        Jdbi me = DBContext.me();
        me.useHandle(handle -> {
            handle.createUpdate(query)
                    .bind(0, idAccount)
                    .bind(1, publicKey)
                    .bind(2, new java.util.Date(System.currentTimeMillis() + (365L * 24L * 60L * 60L * 1000L)))
                    .execute();
        });
    }
    public static List<KeyPairModel> getKeyPairsByIdAccount(int idAccount) {
        String query = "SELECT idAccount, public_key, creation_date, expiration_date FROM key_pairs WHERE idAccount = :idAccount";
        Jdbi me = DBContext.me();

        return me.withHandle(handle -> {
            return handle.createQuery(query)
                    .bind("idAccount", idAccount)
                    .mapToBean(KeyPairModel.class)
                    .list();
        });
    }

    public static KeyPair generateKeyPair() throws NoSuchAlgorithmException {
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
        keyPairGenerator.initialize(2048);

        return keyPairGenerator.generateKeyPair();
    }
    public static void main(String[] args) {
        try {
            // Tạo cặp khóa
            KeyPair keyPair = generateKeyPair();
            // Lấy khóa riêng tư và khóa công khai từ cặp khóa
            //Private Key: MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCUHruMp+QmJA83sKGK4YwX6fMaIQd+cUBh9p2lsXipsA/6C5Dyv/Jz1/H4mM7KuOq5vRlblNFU1dGTCernUiTtSxQYayubfTsTmo5KHrmghOT9TXjIAB4Gh5FQHAGVaVI6ADLXkecuLTeZ4zcazrV3SYL4QLpSqT2Tu2RYFQUrr9piDxxUXNIiB/jueXZR2WwKpNgD9Pb6gZKKC3nARi68qi22dtGJyJ4HF9PV/54Sfn1XOp5x/fz1V65zkiDlrzMNazpOO10U2td1zcOr+3r+LZxgXb34QZ5gzTx1pm4N21s8+/f5tfZ6LJUorvuuJqng8OycXRdkkDsGxzN6n1YXAgMBAAECggEAGVkfEIWk4jAWmJm2M43Ay1DipQyU+zsHYRxywynZc/So70oubpSRuehxRPFlpkS6CrpFTipsHoAPAwJV/GtO3XsVP86LYmsugn7XLfEPJFzJ0V2CN3vpp4VoxVRdowOoqjtheAnEjd74HnJHemN4o6blbnWpTT8gRhlyJS7HuT92tmCGL5Mh2K7Z8ahhxJMJJRcm8zqdFsY1bvqY4zBW+Ci9uNibByXAgjiyOcG5V5F7MyCu21ed6sXFrvTJ3hxE/yjeRe55Hz0BTahX9PRLxVDNsJZKSn55pmBe/3zEgMFzjk7MtB4HKSAfNblGY5MrF5Db6MIz5y3MnKfueDsFjQKBgQC35t6z5I2arDpSzEgGlG/Z8W/hL22Ps3y7vHcQNf6/R6ueAp16XLgjeJisBao6Lr2f5LSdUZcl5YsYpg+hf77x8ber0ooe+HDkco1gpUvD5ZYOnEkKw+sdyqwglmP36S3IBOYDcSQl1fTXEJyWV132Q1/rdLJlDVcKvHzFEIYg5QKBgQDOMKiDu95LcrqQW5eJcUVUgyIthd7gBvPCxPNzEx/dGX5LvMoEG6o3eRH7a08NyPXQby6j05gmFhg90QOdSmKKGDNkgvToYoIb8lWcqk47yjUVjsLFPday3+DS1WSV/uz0W9V5BruIpWvJ4CNgIHU2ng7sGH8kTMyFXK/pLZC3SwKBgFqEtuWQ/+o8D9ElX+ZtNcjuwAT1FVaAIEs/7tL54NRB8MUrwFu0O6ap+2vgtfNBgnCrYAN3X5B1tcuCIXt6p3/rXF6kmPu5icfIYrJJakuYPA4g+wrjeF0Hn0XDAJ3MFo63aogTLpm5AHTDZm/RvRwz+Yipvg1jTY6pTDirc3nJAoGBAMoErKbdZBCCKT6VLuTwASCrlsoJdvQCe8SiGXDvFPIZLz/figL6ZA0T50VxvzPfaNC+jnDfORxf24J9jlAG+IMa8QeSs4gYNChTiAQGbL5yAQ7NIBIG45vAdFO91l6MNfe5HnAE46sfgHt7ys09H/rSZAZ4feHACUbFKGmLRlX/AoGBAJEwIy8Kkj8aqbzCOPKWl2kZ1rvckJvDD7MlCoLklfLefw0JFrcDvG4ByCTCfqxEVx4zv6/1MBZxSlwxT+YVKkFjInCWEcLj75Co0IONFVY7DrqePV0y6nWQbWu/gIIDkpZw9MK4J6HOKuFcKtd8h2Ko4SAJyzFUdH/VU3yYkWXs
            PrivateKey privateKey = keyPair.getPrivate();
            PublicKey publicKey = keyPair.getPublic();
            // In ra chuỗi biểu diễn của khóa riêng tư và khóa công khai
            System.out.println("Private Key: " + Base64.getEncoder().encodeToString(privateKey.getEncoded()));
            System.out.println("Public Key: " + Base64.getEncoder().encodeToString(publicKey.getEncoded()));
            // Gọi hàm để lưu khóa công khai
            String publicKeyString = Base64.getEncoder().encodeToString(publicKey.getEncoded());
            saveKeyPair(2, publicKeyString);
            System.out.println(getKeyPairsByIdAccount(2));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}


