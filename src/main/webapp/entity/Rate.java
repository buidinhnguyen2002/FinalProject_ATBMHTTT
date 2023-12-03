package entity;

public class Rate {
    private int id;
    private int idAccount;
    private Account account;
    private int idProduct;
    private int numberStar;
    private int status;

    public Rate(int id, int idAccount, Account account, int idProduct, int numberStar, int status) {
        this.id = id;
        this.idAccount = idAccount;
        this.account = account;
        this.idProduct = idProduct;
        this.numberStar = numberStar;
        this.status = status;
    }

    public Rate(int id, int idAccount, int idProduct, int numberStar, int status) {
        this.id = id;
        this.idAccount = idAccount;
        this.idProduct = idProduct;
        this.numberStar = numberStar;
        this.status = status;
    }

    @Override
    public String toString() {
        return "Rate{" +
                "id=" + id +
                ", idAccount=" + idAccount +
                ", account=" + account +
                ", idProduct=" + idProduct +
                ", numberStar=" + numberStar +
                ", status=" + status +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdAccount() {
        return idAccount;
    }

    public void setIdAccount(int idAccount) {
        this.idAccount = idAccount;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    public int getNumberStar() {
        return numberStar;
    }

    public void setNumberStar(int numberStar) {
        this.numberStar = numberStar;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
