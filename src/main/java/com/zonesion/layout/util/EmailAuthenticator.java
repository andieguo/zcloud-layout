package com.zonesion.layout.util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class EmailAuthenticator extends Authenticator {

	private String EmailUser;
	private String EmailPassword;
	
	public EmailAuthenticator(String emailUser, String emailPassword) {
		super();
		EmailUser = emailUser;
		EmailPassword = emailPassword;
	}

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		String un = EmailUser;
		String pw = EmailPassword;
		return new PasswordAuthentication(un, pw);
	}

}
