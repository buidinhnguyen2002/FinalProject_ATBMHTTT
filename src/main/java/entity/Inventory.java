package entity;

import java.sql.Date;

public class Inventory {
	private int idProduct;
	private int id_size_color;
	private int quantity;
	private Date createdDate;
	private Date lastUpdatedDate;

	public Inventory(int id, int quantity) {
		super();
	}

	public Inventory(int quantity) {
		this.quantity = quantity;
	}

	public Inventory(int idProduct, int id_size_color, int quantity, Date createdDate, Date lastUpdatedDate) {
		this.idProduct = idProduct;
		this.id_size_color = id_size_color;
		this.quantity = quantity;
		this.createdDate = createdDate;
		this.lastUpdatedDate = lastUpdatedDate;
	}

	public Inventory(int idProduct, int id_size_color, int quantity) {
		this.idProduct = idProduct;
		this.id_size_color = id_size_color;
		this.quantity = quantity;
	}



	public int getId_size_color() {
		return id_size_color;
	}

	public void setId_size_color(int id_size_color) {
		this.id_size_color = id_size_color;
	}

	public int getIdProduct() {
		return idProduct;
	}

	public void setIdProduct(int idProduct) {
		this.idProduct = idProduct;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Date getLastUpdatedDate() {
		return lastUpdatedDate;
	}

	public void setLastUpdatedDate(Date lastUpdatedDate) {
		this.lastUpdatedDate = lastUpdatedDate;
	}

	@Override
	public String toString() {
		return " quantities=" + quantity ;
	}
}
