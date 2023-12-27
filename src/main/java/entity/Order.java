package entity;

import java.io.Serializable;
import java.util.List;

public class Order implements Serializable {
	private int id;
	private String createAt; // ngay dat
	private String deliveryAt; // ngay giao
	private String statusPay; // Trinh trang thanh toan
	private int idAccount;
	private Account account;
	private double sale; // giam gia
	private double totalPrice;
	private String status;
	private String address;
	private String note;
	private String updateAt; // ngay mua
	private String wardId;
	private String districtId;
	private String signature;
	private int publicKeyId;
	private String transactionId;
	private double feeship;

    public Order(int id, Account account, double totalPrice) {
		this.id=id;
		this.account = account;
		this.totalPrice = totalPrice;
    }

	public String getTransactionId() {
		return transactionId;
	}
	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	public double getFeeship() {
		return feeship;
	}

	public void setFeeship(double feeship) {
		this.feeship = feeship;
	}

	public String getWardId() {
		return wardId;
	}

	public void setWardId(String wardId) {
		this.wardId = wardId;
	}

	public String getDistrictId() {
		return districtId;
	}

	public void setDistrictId(String districtId) {
		this.districtId = districtId;
	}

	private List<OrderDetail> orderDetails;

	public Order() {
		super();
	}

	public Order(int id, String createAt, String deliveryDate, String statusPay, Account account, double sale, String status, String address, String node, String updateAt, List<OrderDetail> orderDetails) {
		this.id = id;
		this.createAt = createAt;
		this.deliveryAt = deliveryDate;
		this.statusPay = statusPay;
		this.account = account;
		this.sale = sale;
		this.status = status;
		this.address = address;
		this.note = node;
		this.updateAt = updateAt;
		this.orderDetails = orderDetails;
	}

	public Order(int id, String createAt, String deliveryDate, String statusPay, int idAccount, Account account, double sale, double totalPrice, String status, String address, String note, String updateAt, String wardId, String districtId, List<OrderDetail> orderDetails) {
		this.id = id;
		this.createAt = createAt;
		this.deliveryAt = deliveryDate;
		this.statusPay = statusPay;
		this.idAccount = idAccount;
		this.account = account;
		this.sale = sale;
		this.totalPrice = totalPrice;
		this.status = status;
		this.address = address;
		this.note = note;
		this.updateAt = updateAt;
		this.wardId = wardId;
		this.districtId = districtId;
		this.orderDetails = orderDetails;
	}

	public Order(int id, String createAt, String statusPay, String status, Account account, double totalPrice, int idAccount) {
		this.id = id;
		this.createAt = createAt;
		this.statusPay = statusPay;
		this.status = status;
		this.idAccount = idAccount;
		this.account = account;
		this.totalPrice = totalPrice;
	}

	public Order(int id, String createAt,String deliveryDate, String statusPay, String status, Account account, double totalPrice) {
		this.id = id;
		this.createAt = createAt;
		this.deliveryAt = deliveryDate;
		this.statusPay = statusPay;
		this.status = status;
		this.account = account;
		this.totalPrice = totalPrice;
	}
	public Order(int id, String createAt, String statusPay, String status, Account account, double totalPrice) {
		this.id = id;
		this.createAt = createAt;
		this.statusPay = statusPay;
		this.status = status;
		this.account = account;
		this.totalPrice = totalPrice;
	}

	public Order(int id, String createAt, String deliveryDate, String statusPay, Account account, double sale, double totalPrice, String status, String address, String node, String updateAt, List<OrderDetail> orderDetails) {
		this.id = id;
		this.createAt = createAt;
		this.deliveryAt = deliveryDate;
		this.statusPay = statusPay;
		this.account = account;
		this.sale = sale;
		this.totalPrice = totalPrice;
		this.status = status;
		this.address = address;
		this.note = node;
		this.updateAt = updateAt;
		this.orderDetails = orderDetails;
	}


	public int getIdAccount() {
		return idAccount;
	}

	public void setIdAccount(int idAccount) {
		this.idAccount = idAccount;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getId() {
		return id;
	}

	public String getCreateAt() {
		return createAt;
	}

	public String getDeliveryAt() {
		return deliveryAt;
	}

	public String getStatusPay() {
		return statusPay;
	}

	public Account getAccount() {
		return account;
	}

	public double getSale() {
		return sale;
	}

	public String getStatus() {
		return status;
	}

	public String getAddress() {
		return address;
	}

	public String getNote() {
		return note;
	}

	public String getUpdateAt() {
		return updateAt;
	}

	public List<OrderDetail> getOrderDetails() {
		return orderDetails;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setCreateAt(String createAt) {
		this.createAt = createAt;
	}

	public void setDeliveryAt(String deliveryAt) {
		this.deliveryAt = deliveryAt;
	}

	public void setStatusPay(String statusPay) {
		this.statusPay = statusPay;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	public void setSale(double sale) {
		this.sale = sale;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public void setUpdateAt(String updateAt) {
		this.updateAt = updateAt;
	}

	public void setOrderDetails(List<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public int getPublicKeyId() {
		return publicKeyId;
	}

	public void setPublicKeyId(int publicKeyId) {
		this.publicKeyId = publicKeyId;
	}

	@Override
	public String toString() {
		return "Order{" +
				"id=" + id +
				", createAt='" + createAt + '\'' +
				", deliveryAt='" + deliveryAt + '\'' +
				", statusPay='" + statusPay + '\'' +
				", idAccount=" + idAccount +
				", account=" + account +
				", sale=" + sale +
				", totalPrice=" + totalPrice +
				", status='" + status + '\'' +
				", address='" + address + '\'' +
				", note='" + note + '\'' +
				", updateAt='" + updateAt + '\'' +
				", wardId='" + wardId + '\'' +
				", districtId='" + districtId + '\'' +
				", signature='" + signature + '\'' +
				", publicKeyId=" + publicKeyId +
				", transactionId='" + transactionId + '\'' +
				", orderDetails=" + orderDetails +
				'}';
	}

	public Order(int id, String createAt, String deliveryAt, String statusPay, int idAccount,
				 double sale, double totalPrice, String address, String note, String wardId, String districtId,
				 List<OrderDetail> orderDetails) {
		this.id = id;
		this.createAt = createAt;
		this.deliveryAt = deliveryAt;
		this.statusPay = statusPay;
		this.idAccount = idAccount;
		this.sale = sale;
		this.totalPrice = totalPrice;
		this.address = address;
		this.note = note;
		this.wardId = wardId;
		this.districtId = districtId;
		this.orderDetails = orderDetails;
	}
	public String orderInfo(){
		return "Order{" +
				"id=" + id +
				", createAt='" + createAt + '\'' +
				", deliveryAt='" + deliveryAt + '\'' +
				", statusPay='" + statusPay + '\'' +
				", idAccount=" + idAccount +
//				", account=" + account +
				", sale=" + sale +
				", totalPrice=" + totalPrice +
				", address='" + address + '\'' +
				", note='" + note + '\'' +
				", wardId='" + wardId + '\'' +
				", districtId='" + districtId + '\'' +
				", orderDetails=" + orderDetails +
				'}';
	}
}

