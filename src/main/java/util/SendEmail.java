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
		sendMailKey("20130338@st.hcmuaf.edu.vn", "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");
	}
}