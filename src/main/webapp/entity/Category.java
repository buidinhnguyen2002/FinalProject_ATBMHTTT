package entity;

public class Category {
	private int id;
	private String nameCategory;
	public Category(int id, String name) {
		super();
		this.id = id;
		this.nameCategory = name;
	}

	public Category(String nameCategory) {
		this.nameCategory = nameCategory;
	}

	public Category() {
		super();
	}

	public Category(int id) {
	}

	@Override
	public String toString() {
		return "Category{" +
				"id=" + id +
				", nameCategory='" + nameCategory + '\'' +
				'}';
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNameCategory() {
		return nameCategory;
	}

	public void setNameCategory(String nameCategory) {
		this.nameCategory = nameCategory;
	}
}
