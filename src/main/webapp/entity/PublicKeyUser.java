package entity;

import java.sql.Timestamp;

public class PublicKeyUser {
    private String publicKey;
    private Timestamp expired;
    private Timestamp createAt;

    public PublicKeyUser(String publicKey, Timestamp expired, Timestamp createAt) {
        this.publicKey = publicKey;
        this.expired = expired;
        this.createAt = createAt;
    }

    public String getPublicKey() {
        return publicKey;
    }

    public void setPublicKey(String publicKey) {
        this.publicKey = publicKey;
    }

    public Timestamp getExpired() {
        return expired;
    }

    public void setExpired(Timestamp expired) {
        this.expired = expired;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }
}
