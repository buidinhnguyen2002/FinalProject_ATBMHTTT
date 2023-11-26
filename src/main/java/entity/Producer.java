package entity;

public class Producer { // nha san suat
	private int idProducer;
	private String nameProducer;
	private String information;
	private String logo;
	private String isActive;
	public Producer(int idProducer, String nameProducer, String information, String logo, String isActive) {
		super();
		this.idProducer = idProducer;
		this.nameProducer = nameProducer;
		this.information = information;
		this.logo = logo;
		this.isActive = isActive;
	}

	public Producer(String nameProducer) {
		this.nameProducer = nameProducer;
	}

	public Producer(String nameProducer,int idProducer) {
		this.nameProducer = nameProducer;
		this.idProducer = idProducer;
	}
	public Producer() {
		super();
	}

	@Override
	public String toString() {
		return "Producer{" +
				"idProducer=" + idProducer +
				", nameProducer='" + nameProducer + '\'' +
				", information='" + information + '\'' +
				", logo='" + logo + '\'' +
				", isActive='" + isActive + '\'' +
				'}';
	}

	public int getIdProducer() {
		return idProducer;
	}
	public void setIdProducer(int idProducer) {
		this.idProducer = idProducer;
	}
	public String getNameProducer() {
		return nameProducer;
	}
	public void setNameProducer(String nameProducer) {
		this.nameProducer = nameProducer;
	}
	public String getInformation() {
		return information;
	}
	public void setInformation(String information) {
		this.information = information;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public String getIsActive() {
		return isActive;
	}
	public void setIsActive(String isActive) {
		this.isActive = isActive;
	}
	
}