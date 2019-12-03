/**
 * 
 */
package controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.alibaba.fastjson.JSONObject;
import model.product.*;
import tools.*;
/**
 * @author Mithrandir
 *
 */
@Controller
public class ProductController {
	private ApplicationContext context;
	
	@RequestMapping(value="/addProduct", method=RequestMethod.POST)
	@ResponseBody
	public void addProduct(
			@RequestParam("file")		MultipartFile[] files,
			@RequestParam("name")		String name,
			@RequestParam("userId")		String userId,
			@RequestParam("price")		String price,
			@RequestParam("time")		String time,
			@RequestParam("description")String description,
			@RequestParam("directory")	String directory,
										HttpServletResponse response,
										HttpServletRequest  request) {
		response.setCharacterEncoding("UTF-8");
		context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
		ProductDAO productDAO = context.getBean("ProductJDBCTemplate", ProductJDBCTemplate.class);
		String imgPath = request.getServletContext().getRealPath("/ProductImage/");
		String iconPath = "";
		int count = 1;
		for(MultipartFile file : files) {
			String fileName = name + "_" + time.replace(" ", "").replace(",", "").replace(":", "") + 
					"_" + count + file.getOriginalFilename();
			ImageTools.saveImage(file, fileName, imgPath);
			iconPath += "#" + fileName;
			count++;
			//#Path1#Path2#Path3...
		}
		Product newProduct = productDAO.addProduct(name, userId, price, time, description, iconPath, directory);
		HttpTools.writeObject(response, newProduct);
	}
	
	@RequestMapping(value="deleteProduct", method=RequestMethod.POST)
	@ResponseBody
	public void deleteProduct(@RequestParam("id")String id, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
		ProductDAO productDAO = context.getBean("ProductJDBCTemplate", ProductJDBCTemplate.class);
		boolean ret = productDAO.deleteProduct(id);
		if(ret) {
			HttpTools.writeJSON(response, "success");
		} else {
			HttpTools.writeJSON(response, "fail");
		}
	}
	
	@RequestMapping(value="searchProduct", method=RequestMethod.POST)
	@ResponseBody
	public void searchProduct(@RequestParam("keyword") String keyword, HttpServletResponse	response) {
		response.setCharacterEncoding("UTF-8");
		context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
		ProductDAO productDAO = context.getBean("ProductJDBCTemplate", ProductJDBCTemplate.class);
		ArrayList<Product> results = productDAO.searchProduct(keyword.split(" "));
		if(results != null) {
			HttpTools.writeObject(response, results);
		} else {
			HttpTools.writeJSON(response, "fail");
		}
		
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	@ResponseBody
	public void updateProduct(
			@RequestParam("file")		MultipartFile[] files,
			@RequestParam("id")			String id,
			@RequestParam("name")		String name,
			@RequestParam("userId")		String userId,
			@RequestParam("price")		String price,
			@RequestParam("time")		String time,
			@RequestParam("description")String description,
			@RequestParam("directory")	String directory,
										HttpServletResponse response,
										HttpServletRequest	request) {
		try {
			response.setCharacterEncoding("UTF-8");
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
		ProductDAO productDAO = context.getBean("ProductJDBCTemplate", ProductJDBCTemplate.class);
		if(files != null && files.length > 0)
		{
			String imgPath = request.getServletContext().getRealPath("/ProductImage/");
			String iconPath = "";
			int count = 1;
			for(MultipartFile file : files) {
				String temp = ImageTools.saveImage(file, name + "_" + time + "_" + count + file.getOriginalFilename(), imgPath);
				iconPath += "#" + temp;
				count++;
				//#Path1#Path2#Path3...
			}
			Product newProduct = productDAO.updateProduct(id, name, userId, price, time, description, iconPath, directory);
			if(newProduct != null) {
				HttpTools.writeObject(response, newProduct);
			} else {
				HttpTools.writeJSON(response, "fail");
			}
		}
	}
}
