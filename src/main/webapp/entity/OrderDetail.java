package entity;

public class OrderDetail {
	private int id;
	private int idOrder;
	private int idProduct;
	private Product product;
	private int quantity; // tong so luong
	private double price;
	private String node; // ghi chu
	private String productSize;
	private String productColor;
	public OrderDetail() {
	}

	public OrderDetail(int id, int idOrder, int idProduct, Product product, int quantity, double price, String node) {
		this.id = id;
		this.idOrder = idOrder;
		this.idProduct = idProduct;
		this.product = product;
		this.quantity = quantity;
		this.price = price;
		this.node = node;
	}

	public OrderDetail(int id, int idOrder, int idProduct, int quantity, double price, String node) {
		this.id = id;
		this.idOrder = idOrder;
		this.idProduct = idProduct;
		this.quantity = quantity;
		this.price = price;
		this.node = node;
	}

	public OrderDetail(int id, int idOrder, int idProduct, Product product, int quantity, double price, String node, String productSize, String productColor) {
		this.id = id;
		this.idOrder = idOrder;
		this.idProduct = idProduct;
		this.product = product;
		this.quantity = quantity;
		this.price = price;
		this.node = node;
		this.productSize = productSize;
		this.productColor = productColor;
	}

	public String getProductSize() {
		return productSize;
	}

	public void setProductSize(String productSize) {
		this.productSize = productSize;
	}

	public String getProductColor() {
		return productColor;
	}

	public void setProductColor(String productColor) {
		this.productColor = productColor;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdOrder() {
		return idOrder;
	}

	public void setIdOrder(int idOrder) {
		this.idOrder = idOrder;
	}

	public int getIdProduct() {
		return idProduct;
	}

	public void setIdProduct(int idProduct) {
		this.idProduct = idProduct;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getNode() {
		return node;
	}

	public void setNode(String node) {
		this.node = node;
	}

	@Override
	public String toString() {
		return "OrderDetail{" +
				"id=" + id +
				", idOrder=" + idOrder +
				", idProduct=" + idProduct +
				", quantity=" + quantity +
				", price=" + price +
				", node='" + node + '\'' +
				", productSize='" + productSize + '\'' +
				", productColor='" + productColor + '\'' +
				'}';
	}
}