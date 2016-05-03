package com.zonesion.layout.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.zonesion.layout.model.AdminEntity;

/**  
 * 在业务处理器处理请求之前preHandle被调用  
 * 如果返回false  
 *     从当前的拦截器往回执行所有拦截器的afterCompletion(),再退出拦截器链 
 * 如果返回true  
 *    执行下一个拦截器,直到所有的拦截器都执行完毕  
 *    再执行被拦截的Controller  
 *    然后进入拦截器链,  
 *    从最后一个拦截器往回执行所有的postHandle()  
 *    接着再从最后一个拦截器往回执行所有的afterCompletion()  
 */    
public class LoginInterceptor extends HandlerInterceptorAdapter{
	private final Logger logger = Logger.getLogger(LoginInterceptor.class);

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}

	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub
		super.afterConcurrentHandlingStarted(request, response, handler);
	}
	
	/** 
     * 在业务处理器处理请求执行完成后,生成视图之前执行的动作    
     * 可在modelAndView中加入数据，比如当前时间 
     */  
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub
	    logger.info("==============执行顺序: 1、preHandle================");    
        String requestUri = request.getRequestURI();  
        String contextPath = request.getContextPath();  
        String url = requestUri.substring(contextPath.length());  
        
        logger.info("requestUri:"+requestUri);    
        logger.info("contextPath:"+contextPath);    
        logger.info("url:"+url);    
          
        AdminEntity admin =  (AdminEntity)request.getSession().getAttribute("admin");   
        if(admin == null ){
        	logger.info("Interceptor：跳转到login页面！");
        	response.sendRedirect(contextPath+"/admin/loginUI");
            return false;  
        }else  
            return true;   
	}

}
