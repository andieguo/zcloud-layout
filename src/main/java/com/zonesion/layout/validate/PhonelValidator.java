package com.zonesion.layout.validate;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Component;
/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月22日 下午5:12:18  
 * @version V1.0    
 */
@Component("phoneValidator")
public class PhonelValidator {

	private Pattern pattern;
	private Matcher matcher;

	private static final String PHONE_PATTERN = "^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";

	public PhonelValidator() {
		pattern = Pattern.compile(PHONE_PATTERN);
	}

	public boolean valid(final String email) {

		matcher = pattern.matcher(email);
		return matcher.matches();

	}
}
