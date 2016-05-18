package com.zonesion.layout.controller;

import java.net.NoRouteToHostException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.mysql.jdbc.exceptions.jdbc4.CommunicationsException;


/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年5月18日 下午4:10:42  
 * @version V1.0    
 */
public class ExceptionHandler implements HandlerExceptionResolver {

	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
		// TODO Auto-generated method stub
		//同一处理异常
		if(ex instanceof NoRouteToHostException){
			
		}
		if(ex instanceof CommunicationsException){
			
		}
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("message", model);
		System.out.println(ex.toString());
		return new ModelAndView("/error/error",model);
	}

}
