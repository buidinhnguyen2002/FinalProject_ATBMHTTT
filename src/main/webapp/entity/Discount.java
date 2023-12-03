package entity;

import java.sql.Date;
import java.util.List;

public class Discount {
	private int id;
	private String nameDiscount;
	private String description;
	private String codeDiscount;
	private double percentage;
	private int quantity;
	private String startTime;
	private String endTime;
	private String status;
	private String createAt;

	private String updateAt;
	public Discount() {
	}

	public Discount(int id, String nameDiscount, String description, String codeDiscount, double percentage, int quantity, String startTime, String endTime, String status, String createAt, String updateAt) {
		this.id = id;
		this.nameDiscount = nameDiscount;
		this.description = description;
		this.codeDiscount = codeDiscount;
		this.percentage = percentage;
		this.quantity = quantity;
		this.startTime = startTime;
		this.endTime = endTime;
		this.status = status;
		this.createAt = createAt;
		this.updateAt = updateAt;
	}

	public Discount(int id, String nameDiscount, String description, String codeDiscount, double percentage, int quantity, String startTime, String endTime, String status) {
		this.id = id;
		this.nameDiscount = nameDiscount;
		this.description = description;
		this.codeDiscount = codeDiscount;
		this.percentage = percentage;
		this.quantity = quantity;
		this.startTime = startTime;
		this.endTime = endTime;
		this.status = status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNameDiscount() {
		return nameDiscount;
	}

	public void setNameDiscount(String nameDiscount) {
		this.nameDiscount = nameDiscount;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCodeDiscount() {
		return codeDiscount;
	}

	public void setCodeDiscount(String codeDiscount) {
		this.codeDiscount = codeDiscount;
	}

	public double getPercentage() {
		return percentage;
	}

	public void setPercentage(double percentage) {
		this.percentage = percentage;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCreateAt() {
		return createAt;
	}

	public void setCreateAt(String createAt) {
		this.createAt = createAt;
	}

	public String getUpdateAt() {
		return updateAt;
	}

	public void setUpdateAt(String updateAt) {
		this.updateAt = updateAt;
	}

	@Override
	public String toString() {
		return "Discount{" +
				"id=" + id +
				", nameDiscount='" + nameDiscount + '\'' +
				", description='" + description + '\'' +
				", codeDiscount='" + codeDiscount + '\'' +
				", percentage=" + percentage +
				", quantity=" + quantity +
				", startTime='" + startTime + '\'' +
				", endTime='" + endTime + '\'' +
				", status='" + status + '\'' +
				", createAt='" + createAt + '\'' +
				", updateAt='" + updateAt + '\'' +
				'}';
	}
}
