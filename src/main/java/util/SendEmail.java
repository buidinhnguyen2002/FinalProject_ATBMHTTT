package util;

import entity.AES;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.util.Date;
import java.util.Properties;

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
	public static void sendMailKey(String addressTo, String publicKey, String privateKey) {
		// khai báo
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");

		// write keys
		writeKeysToFile(privateKey);

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
			MimeBodyPart contentPart = new MimeBodyPart();
			contentPart.setContent("<p><strong>Public key:</strong> " + publicKey + "</p><p><strong>Private key:</strong> " + privateKey + "</p>", "text/html; charset=UTF-8");

			MimeBodyPart attachmentPart = new MimeBodyPart();
			AES aes = new AES();
			aes.encryptAESFile("keys.txt", "private_key.txt", "");
			attachmentPart.attachFile(new File("private_key.txt"));

			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(contentPart);
			multipart.addBodyPart(attachmentPart);

			msg.setContent(multipart);

			// Gửi mail
			Transport.send(msg);

			File file = new File("keys.txt");
			File filePrivateKey = new File("private_key.txt");
			if (file.exists()) {
				file.delete();
			}
			if (filePrivateKey.exists()) {
				filePrivateKey.delete();
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

//	// write key in file txt
//	public static void writeKeysToFile(String publicKey, String privateKey) {
//		try (FileWriter fw = new FileWriter("keys.txt")) {
//			fw.write("PublicKey: " + publicKey + "\n" + "/n");
//			fw.write("PrivateKey: " + privateKey);
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	}

	// write key in file txt
	public static void writeKeysToFile(String privateKey) {
		try (FileWriter fw = new FileWriter("keys.txt")) {
			fw.write(privateKey);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
//		sendMailFogetPassWord("leminhlongit@gmail.com", "KHASasd");
//		RSA rsa = new RSA(2048);
//		String publicKey = rsa.exportPublicKey();
//		System.out.println(publicKey);
//		SendEmail.sendMailKey("rynvia1522@gmail.com", "ok nha", "rsa.hello()");
		sendMailKey("20130316@st.hcmuaf.edu.vn", "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");
	}
}