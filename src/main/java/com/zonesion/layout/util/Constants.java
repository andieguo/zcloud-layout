package com.zonesion.layout.util;

import java.io.File;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年5月28日 上午10:24:51  
 * @version V1.0    
 */
public class Constants {
	public static final String HOMEPATH = System.getProperty("user.home");
	public static final String PROJECTNAME = "zcloud-layout";
	public static final String PROJECTPATH = HOMEPATH+File.separator+PROJECTNAME;	
	public static final String LAYOUT_TEMPLATE_PATH = PROJECTPATH+File.separator+"template";
	public static final String LAYOUT_PROJECT_PATH = PROJECTPATH+File.separator+"project";
	
	static{
		mkdir(PROJECTPATH);
		mkdir(LAYOUT_TEMPLATE_PATH);
		mkdir(LAYOUT_PROJECT_PATH);
	} 
	
	public static void mkdir(String path){
		File file = new File(path);
		if(!file.exists()){
			file.mkdirs();
		}
	}



}
