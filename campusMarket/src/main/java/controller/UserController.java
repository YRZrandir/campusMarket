/**
 * 
 */
package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import model.user.*;
import tools.*;

/**
 * @author Mithrandir
 *
 */
@Controller
public class UserController {
	private ApplicationContext context;
	
	@CrossOrigin	(origins = "*")
	@RequestMapping	(value="/login", method=RequestMethod.POST)
	@ResponseBody
	public void login(
			@RequestParam("id")			String id,
			@RequestParam("password")	String password,
										HttpServletRequest request,
										HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
			UserDAO userDAO = context.getBean("UserJDBCTemplate", UserJDBCTemplate.class);
			
			User user = userDAO.getUserByIdAndPassword(id, password);
			HttpTools.writeJSON(response, user.toString());
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			HttpTools.writeJSON(response, "fail");
		}
	}
	
	@CrossOrigin	(origins = "*")
	@RequestMapping	(value="/register", method=RequestMethod.POST)
	@ResponseBody
	public void register(
			@RequestParam("file")		MultipartFile file,
			@RequestParam("id")			String id,
			@RequestParam("name")		String name,
			@RequestParam("password")	String password,
			@RequestParam("gender")		String gender,
			@RequestParam("school")		String school,
			@RequestParam("campus")		String campus,
			@RequestParam("telephone")	String telephone,
										HttpServletRequest request,
										HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			System.out.println("image name : " + file.getOriginalFilename());
			System.out.println("RegisterInfo : " + id + " " + 
			name + " " + password + " " + gender + " " + school + " " + campus + " " + telephone);
			
			String path = request.getServletContext().getRealPath("/Image/");
			String iconPath = ImageTools.saveImage(file, id + "_" + file.getOriginalFilename(), path);

			context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
			UserDAO userDAO = context.getBean("UserJDBCTemplate", UserJDBCTemplate.class);
			
			User newUser = userDAO.addUser(id, name, password, gender, school, campus, iconPath, telephone);
			HttpTools.writeJSON(response, newUser.toString());
		} catch (IOException e) {
			e.printStackTrace();
			HttpTools.writeJSON(response, "fail");
		}
	}
	
	@CrossOrigin	(origins = "*")
	@RequestMapping	(value="/updateUser", method=RequestMethod.POST)
	@ResponseBody
	public void updateUser(
			@RequestParam("file")		MultipartFile file,
			@RequestParam("id")			String id,
			@RequestParam("name")		String name,
			@RequestParam("password")	String password,
			@RequestParam("gender")		String gender,
			@RequestParam("school")		String school,
			@RequestParam("campus")		String campus,
			@RequestParam("telephone")	String telephone,
										HttpServletRequest request,
										HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			String path = request.getServletContext().getRealPath("/Image/");
			String iconPath = ImageTools.saveImage(file, id + "_" + file.getOriginalFilename(), path);

			context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
			UserDAO userDAO = context.getBean("UserJDBCTemplate", UserJDBCTemplate.class);
			
			User newUser = userDAO.updateUser(id, name, password, gender, school, campus, iconPath, telephone);
			HttpTools.writeJSON(response, newUser.toString());
		} catch(IOException e) {
			e.printStackTrace();
			HttpTools.writeJSON(response, "fail");
		}
	}
}
