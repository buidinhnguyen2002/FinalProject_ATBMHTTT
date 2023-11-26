package util;

import java.util.Date;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmail {
	static final String from = "leminhlongg0902@gmail.com";
	static final String password = "kxyvjmqrualglkid";
	
	// Ramdom Mật khẩu
	public static String getRandomPass(int n)
	 {
	 
	  // chose a Character random from this String
	  String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	         + "0123456789"
	         + "abcdefghijklmnopqrstuvxyz";
	 
	  // create StringBuffer size of AlphaNumericString
	  StringBuilder sb = new StringBuilder(n);
	 
	  for (int i = 0; i < n; i++) {
	 
	   // generate a random number between
	   // 0 to AlphaNumericString variable length
	   int index
	    = (int)(AlphaNumericString.length()
	      * Math.random());
	 
	   // add Character one by one in end of sb
	   sb.append(AlphaNumericString
	      .charAt(index));
	  }
	 
	  return sb.toString();
	 }
	public static void sendMailFogetPassWord(String addressTo, String MessagePassword) {

		// khai báo
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");

		// Tao auth
		Authenticator auth = new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				// TODO Auto-generated method stub
				return new PasswordAuthentication(from, password);
			}

		};
		// phiên làm việc
		Session session = Session.getInstance(props, auth);
		// Gửi Email

		// Tạo một tin nhắn
		MimeMessage msg = new MimeMessage(session);
		try {
			msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
			msg.setFrom(new InternetAddress(from, "HaLo's Shop"));
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(addressTo, false));
			msg.setSubject("HaLo's Shop");
			msg.setSentDate(new Date());
			// Nội dung

			msg.setText("Mật khẩu OTP của bạn là: " + MessagePassword + "\nMật khẩu này chỉ có tác dụng trong 5 phút vui lòng sửa mật khẩu sau khi đăng nhập thành công.", "UTF-8");
			// Gửi mail
			Transport.send(msg);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
//		sendMailFogetPassWord("leminhlongit@gmail.com", "KHASasd");
		
	}
}