/**
 * 
 */
package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

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
			@RequestParam("files")		MultipartFile[] files,
			@RequestParam("name")		String name,
			@RequestParam("userId")		String userId,
			@RequestParam("time")		String time,
			@RequestParam("description")String description,
			@RequestParam("directory")	String directory,
										HttpServletResponse response) {
		
		
	}
	
	@RequestMapping(value="deleteProduct", method=RequestMethod.POST)
	@ResponseBody
	public void deleteProduct(@RequestParam("id")String id, HttpServletResponse response) {
		
	}
	
	@RequestMapping(value="deleteProduct", method=RequestMethod.POST)
	@ResponseBody
	public void searchProduct(
			@RequestParam("name")		String name,
			@RequestParam("school")		String school,
			@RequestParam("campus")		String campus,
			@RequestParam("directory")	String directory,
										HttpServletResponse	response) {
		
	}
	
	@RequestMapping(value="deleteProduct", method=RequestMethod.POST)
	@ResponseBody
	public void updateProduct(
			@RequestParam("files")		MultipartFile[] files,
			@RequestParam("id")			String id,
			@RequestParam("name")		String name,
			@RequestParam("time")		String time,
			@RequestParam("description")String description,
			@RequestParam("directory")	String directory,
										HttpServletResponse response) {
			
	}
}
