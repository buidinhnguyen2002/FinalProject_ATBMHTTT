package entity;

public class Supplier { // nha cung cap
	private int idSupplier;
	private String nameSupplier;
	private String emailSupplier;
	private String numberPhone;

	public Supplier(){
	}

	public Supplier(int idSupplier, String nameSupplier, String emailSupplier, String numberPhone) {
		super();
		this.idSupplier = idSupplier;
		this.nameSupplier = nameSupplier;
		this.emailSupplier = emailSupplier;
		this.numberPhone = numberPhone;
	}

	public Supplier(String nameSupplier) {
		this.nameSupplier = nameSupplier;
	}

	@Override
	public String toString() {
		return "Supplier [idSupplier=" + idSupplier + ", nameSupplier=" + nameSupplier + ", emailSupplier="
				+ emailSupplier + ", numberPhone=" + numberPhone +  "]";
	}
	public int getIdSupplier() {
		return idSupplier;
	}
	public void setIdSupplier(int idSupplier) {
		this.idSupplier = idSupplier;
	}
	public String getNameSupplier() {
		return nameSupplier;
	}
	public void setNameSupplier(String nameSupplier) {
		this.nameSupplier = nameSupplier;
	}
	public String getEmailSupplier() {
		return emailSupplier;
	}
	public void setEmailSupplier(String emailSupplier) {
		this.emailSupplier = emailSupplier;
	}
	public String getNumberPhone() {
		return numberPhone;
	}
	public void setNumberPhone(String numberPhone) {
		this.numberPhone = numberPhone;
	}


}
