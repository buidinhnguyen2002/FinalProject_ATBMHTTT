package sign;
import java.util.Date;
public class KeyPairModel {
    private int idAccount;
    private String public_key;
    private Date creation_date;
    private Date expiration_date;
    private Date cancellation_date;

    @Override
    public String toString() {
        return "KeyPairModel{" +
                "idAccount=" + idAccount +
                ", public_key='" + public_key + '\'' +
                ", creation_date=" + creation_date +
                ", expiration_date=" + expiration_date +
                ", cancellation_date=" + cancellation_date +
                '}';
    }

    public KeyPairModel() {
    }

    public int getIdAccount() {
        return idAccount;
    }

    public void setIdAccount(int idAccount) {
        this.idAccount = idAccount;
    }

    public String getPublic_key() {
        return public_key;
    }

    public void setPublic_key(String public_key) {
        this.public_key = public_key;
    }

    public Date getCreation_date() {
        return creation_date;
    }

    public void setCreation_date(Date creation_date) {
        this.creation_date = creation_date;
    }

    public Date getExpiration_date() {
        return expiration_date;
    }

    public void setExpiration_date(Date expiration_date) {
        this.expiration_date = expiration_date;
    }

    public Date getCancellation_date() {
        return cancellation_date;
    }

    public void setCancellation_date(Date cancellation_date) {
        this.cancellation_date = cancellation_date;
    }

    public KeyPairModel(int idAccount, String public_key, Date creation_date, Date expiration_date, Date cancellation_date) {
        this.idAccount = idAccount;
        this.public_key = public_key;
        this.creation_date = creation_date;
        this.expiration_date = expiration_date;
        this.cancellation_date = cancellation_date;
    }
}
