package entity;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;

public class Comment {
	private int id;
	private String content;
	private int idCustomer;
	private int idProduct;

	private int idParent;
	private String status;
	private int level;
	private String  createAt;
	private String nameAccount;

	private List<Comment> listreply;

	private String differencetime;

	public Comment() {
	}

	public Comment(int id, String content, int idCustomer, int idProduct, String createAt, String nameAccount, List<Comment> listreply) {
		this.id = id;
		this.content = content;
		this.idCustomer = idCustomer;
		this.idProduct = idProduct;
		this.createAt = createAt;
		this.nameAccount = nameAccount;
		this.listreply = listreply;
	}

	public List<Comment> getListreply() {
		return listreply;
	}

	public void setListreply(List<Comment> listreply) {
		this.listreply = listreply;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getIdCustomer() {
		return idCustomer;
	}

	public void setIdCustomer(int idCustomer) {
		this.idCustomer = idCustomer;
	}

	public int getIdProduct() {
		return idProduct;
	}

	public void setIdProduct(int idProduct) {
		this.idProduct = idProduct;
	}

	public int getIdParent() {
		return idParent;
	}

	public void setIdParent(int idParent) {
		this.idParent = idParent;
	}

	public String getStatus() {
		return status;
	}

	public String getDifferencetime() {
		return differencetime;
	}

	public void setDifferencetime(String differencetime) {
		this.differencetime = differencetime;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public String getCreateAt() {
		return createAt;
	}

	public void setCreateAt(String createAt) {
		this.createAt = createAt;
		this.differencetime=gettimeover();
	}

	public String getNameAccount() {
		return nameAccount;
	}

	public void setNameAccount(String nameAccount) {
		this.nameAccount = nameAccount;
	}

	@Override
	public String toString() {
		return "Comment{" +
				"id=" + id +
				", content='" + content + '\'' +
				", idCustomer=" + idCustomer +
				", idProduct=" + idProduct +
				", idParent=" + idParent +
				", status='" + status + '\'' +
				", level=" + level +
				", createAt='" + createAt + '\'' +
				", nameAccount='" + nameAccount + '\'' +
				", listreply=" + listreply +
				'}'+'\n';
	}

		public String gettimeover (){
		String rs = "";
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime now = LocalDateTime.now();
			ZoneId zone = ZoneId.of("Asia/Ho_Chi_Minh");
			LocalDateTime commentTime = LocalDateTime.parse(createAt, formatter).atZone(zone).toLocalDateTime();

			Duration duration = Duration.between(commentTime, now);

			long seconds = duration.getSeconds();
			long minutes = duration.toMinutes();
			long hours = duration.toHours();
			long days = duration.toDays();

			if (seconds<60){
				return rs.format("%d giây trước",seconds );
			}
			if(minutes<60){
				return String.format("%d phút trước",minutes );

			}
			if(hours<24) {
				return String.format("%d giờ trước", hours);
			}
			else{
				return String.format("%d ngày trước", days);
			}

}

}


