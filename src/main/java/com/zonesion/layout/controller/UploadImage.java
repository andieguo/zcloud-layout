package com.zonesion.layout.controller;

import java.io.File;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: TODO 
 * @date 2016年4月26日 上午11:10:36  
 * @version V1.0    
 */
@Controller
public class UploadImage {

	@RequestMapping(value = "/uploadImage", method = RequestMethod.POST)
	protected void upload(HttpServletRequest request, HttpServletResponse response){
		// TODO Auto-generated method stub
	    File uploadPath = new File((String)request.getRealPath("photo")+"/");//上传文件目录
	    
	    if (!uploadPath.exists()) {
	       uploadPath.mkdirs();
	    }
	    // 临时文件目录
	    File tempPathFile = new File((String)request.getRealPath("photo")+"/");
	    if (!tempPathFile.exists()) {
	       tempPathFile.mkdirs();
	    }
	    try {
	       // Create a factory for disk-based file items
	       DiskFileItemFactory factory = new DiskFileItemFactory();
	 
	       // Set factory constraints
	       factory.setSizeThreshold(4096); // 设置缓冲区大小，这里是4kb
	       factory.setRepository(tempPathFile);//设置缓冲区目录
	 
	       // Create a new file upload handler
	       ServletFileUpload upload = new ServletFileUpload(factory);
	 
	       // Set overall request size constraint
	       upload.setSizeMax(4194304); // 设置最大文件尺寸，这里是4MB
	 
	       List<FileItem> items = upload.parseRequest(request);//得到所有的文件
	       Iterator<FileItem> i = items.iterator();
	       while (i.hasNext()) {
	           FileItem fi = (FileItem) i.next();
	           String fileName = fi.getName();
	           System.out.println(fileName);
	           if (fileName != null) {
			       File fullFile = new File(fi.getName());
			       long currentTime=System.currentTimeMillis() ;
	 			   String newFileName = "MT_"+Long.toString(currentTime)+".jpg";
			       File savedFile = new File(uploadPath, newFileName);
			       fi.write(savedFile);
	           }
	       }
	       System.out.println("upload succeed");
	    } catch (Exception e) {
	       e.printStackTrace();
	    }		
	}

	
}
