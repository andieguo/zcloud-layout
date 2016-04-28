package com.zonesion.layout.util;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {
	
	private String EmailServer = null;
	private String EmailUser = null;
	private String EmailPassword = null;
	
	public EmailUtil(String emailServer, String emailUser, String emailPassword) {
		super();
		EmailServer = emailServer;
		EmailUser = emailUser;
		EmailPassword = emailPassword;
	}


	/**
	 * 发送简单邮件
	 * 
	 * @param str_from
	 *            ：发件人地址
	 * @param str_to
	 *            :收件人地址
	 * @param str_title
	 *            ：邮件标题
	 * @param str_content
	 *            ：邮件正文
	 */
	public void send(String str_from, String str_to, String str_title, String str_content) {

		try {
			// 建立邮件会话
			Properties props = new Properties(); // 用来在一个文件中存储键-值对的，其中键和值是用等号分隔的，
			// 存储发送邮件服务器的信息
			props.put("mail.smtp.host", EmailServer);
			// 同时通过验证
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", 465);
			props.put("mail.smtp.socketFactory.port", 465);//添加SSL验证:SMTP发件服务器的端口号为465
			props.put("mail.smtp.starttls.enable","true");
			EmailAuthenticator auth = new EmailAuthenticator(EmailUser, EmailPassword);// 服务器认证
			// 根据属性新建一个邮件会话
			Session s = Session.getInstance(props, auth);
			s.setDebug(true); // 有他会打印一些调试信息。

			// 由邮件会话新建一个消息对象
			MimeMessage message = new MimeMessage(s);
			// 设置邮件
			InternetAddress from = new InternetAddress(str_from); // pukeyouxintest2@163.com
			message.setFrom(from); // 设置发件人的地址
			// 设置收件人,并设置其接收类型为TO
			InternetAddress to = new InternetAddress(str_to); // pukeyouxintest3@163.com
			message.setRecipient(Message.RecipientType.TO, to);

			// 设置标题
			message.setSubject(str_title); // java学习

			// 设置信件内容
			// message.setText(str_content); //发送文本邮件 //你好吗？
			message.setContent(str_content, "text/html;charset=gb2312"); // 发送HTML邮件
			// 设置发信时间
			message.setSentDate(new Date());

			// 存储邮件信息
			message.saveChanges();

			// 发送邮件
			Transport transport = s.getTransport("smtp");
			// 以smtp方式登录邮箱,第一个参数是发送邮件用的邮件服务器SMTP地址,第二个参数为用户名,第三个参数为密码
			transport.connect(EmailServer, EmailUser, EmailPassword);
			// 发送邮件,其中第二个参数是所有已设好的收件人地址
			transport.sendMessage(message, message.getAllRecipients());
			transport.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void sendList(String str_from, List<String> str_tos, String str_title, String str_content) {

		try {
			// 建立邮件会话
			Properties props = new Properties(); // 用来在一个文件中存储键-值对的，其中键和值是用等号分隔的，
			// 存储发送邮件服务器的信息
			props.put("mail.smtp.host", EmailServer);
			// 同时通过验证
			props.put("mail.smtp.auth", "true");
			EmailAuthenticator auth = new EmailAuthenticator(EmailUser, EmailPassword);// 服务器认证
			// 根据属性新建一个邮件会话
			Session s = Session.getInstance(props, auth);
			s.setDebug(true); // 有他会打印一些调试信息。

			// 由邮件会话新建一个消息对象
			MimeMessage message = new MimeMessage(s);
			// 设置邮件
			InternetAddress from = new InternetAddress(str_from); // pukeyouxintest2@163.com
			message.setFrom(from); // 设置发件人的地址

			// 群发，设置收件人
			List<InternetAddress> list = new ArrayList<InternetAddress>();// 不能使用string类型的类型，这样只能发送一个收件人
			for (int i = 0; i < str_tos.size(); i++) {
				list.add(new InternetAddress(str_tos.get(i)));
			}
			InternetAddress[] address = (InternetAddress[]) list.toArray(new InternetAddress[list.size()]);
			message.setRecipients(Message.RecipientType.TO, address);// 当邮件有多个收件人时，用逗号隔开

			// 设置标题
			message.setSubject(str_title); // java学习

			// 设置信件内容
			// message.setText(str_content); //发送文本邮件 //你好吗？
			message.setContent(str_content, "text/html;charset=gb2312"); // 发送HTML邮件
			// 设置发信时间
			message.setSentDate(new Date());

			// 存储邮件信息
			message.saveChanges();

			// 发送邮件
			Transport transport = s.getTransport("smtp");
			// 以smtp方式登录邮箱,第一个参数是发送邮件用的邮件服务器SMTP地址,第二个参数为用户名,第三个参数为密码
			transport.connect(EmailServer, EmailUser, EmailPassword);
			// 发送邮件,其中第二个参数是所有已设好的收件人地址
			transport.sendMessage(message, message.getAllRecipients());
			transport.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		//zonesion.com.cn的STMP服务器为smtp.mxhichina.com
		EmailUtil emailUtil = new EmailUtil("smtp.mxhichina.com", "guodong@zonesion.com.cn", "");
		emailUtil.send("guodong@zonesion.com.cn", "andieguo@163.com", "test", "test content");
		//qq.com的STMP服务器为smtp.qq.com
//		EmailUtil emailUtil = new EmailUtil("smtp.qq.com", "andieguo@qq.com", "");
//		emailUtil.send("756074909@qq.com", "andieguo@163.com", "test", "test content");
		//163.com的STMP服务器为smtp163.com
//		EmailUtil emailUtil = new EmailUtil("smtp.163.com", "andieguo@163.com", "");
//		emailUtil.send("andieguo@163.com", "756074909@qq.com", "test", "test content");
	}

}
