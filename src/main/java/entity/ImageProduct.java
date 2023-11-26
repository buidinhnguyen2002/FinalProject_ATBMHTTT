package entity;

public class ImageProduct {
	private int id;
	private int idProduct;
	private String image;

	@Override
	public String toString() {
		return image ;
	}

	public ImageProduct() {
	}

	public ImageProduct(int id, int idProduct, String image) {
		this.id = id;
		this.idProduct = idProduct;
		this.image = image;
	}

	public int getId() {
		return id;
	}

	public int getIdProduct() {
		return idProduct;
	}

	public String getImage() {
		return image;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setIdProduct(int idProduct) {
		this.idProduct = idProduct;
	}

	public void setImage(String image) {
		this.image = image;
	}
}
