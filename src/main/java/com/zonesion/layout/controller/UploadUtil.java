package com.zonesion.layout.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: 上传文件到服务器工具类 
 * @date 2016年5月28日 上午10:36:28  
 * @version V1.0    
 */
public class UploadUtil {

	public static String upload(File stoageHome,HttpServletRequest request) throws Exception{
		String contentType = request.getContentType();
		if (contentType.indexOf("multipart/form-data") >= 0) {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// 设置内存中存储文件的最大值
			factory.setSizeThreshold(5000 * 1024);
			// 本地存储的数据大于 maxMemSize.
			factory.setRepository(stoageHome);
			// 创建一个新的文件上传处理程序
			ServletFileUpload upload = new ServletFileUpload(factory);
			// 设置最大上传的文件大小
			upload.setSizeMax(5000 * 1024);
			// 上传文件，并解析出所有的表单字段，包括普通字段和文件字段
			List<FileItem> items = upload.parseRequest(request);
			// 下面对每个字段进行处理，分普通字段和文件字段
			Iterator<?> it = items.iterator();
			while (it.hasNext()) {
				FileItem fileItem = (FileItem) it.next();
				// 如果是文件
				if (!fileItem.isFormField()) {
					System.out.println(fileItem.getFieldName() + "   " + fileItem.getName() + "   " + fileItem.isInMemory() + "    " + fileItem.getContentType() + "   " + fileItem.getSize());
					// 保存文件，其实就是把缓存里的数据写到目标路径下
					if (fileItem.getName() != null && fileItem.getSize() != 0) {
						// File fullFile = new File(fileItem.getName());
						String[] array = fileItem.getName().split("\\\\");
						//写入文件
						File newFile = new File(stoageHome.getPath() + File.separator + array[array.length - 1]);
						try {
							fileItem.write(newFile);
						} catch (Exception e) {
							e.printStackTrace();
						}
						//读文件,使用本地环境中的默认字符集，例如在中文环境中将使用 GBK编码
						BufferedReader in = new BufferedReader(new InputStreamReader(new FileInputStream(newFile),"UTF-8"));
						StringBuffer content = new StringBuffer();
						String line = null;
						while((line = in.readLine()) != null){
							content.append(line);
						}
						in.close();
						if (newFile.exists()) {
							newFile.delete();
						}
						return content.toString();
					}
				}
			}
		}
		return null;
	}
}
