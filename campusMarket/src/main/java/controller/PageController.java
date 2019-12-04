package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.net.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import model.product.*;
import model.user.*;
import tools.CookieTools;

@Controller
public class PageController {
	
	
	@RequestMapping(value = "/loginPage", method=RequestMethod.GET)
	public String loginPage() {
		return "login";
	}

	@RequestMapping(value = "/index", method=RequestMethod.GET)
	public String indexPage(HttpServletRequest request, HttpSession session) {
		checkCookie(request, session);
		return "index";
	}

	@RequestMapping(value = "/registerPage", method=RequestMethod.GET)
	public String registerPage() {
		return "register";
	}

	@RequestMapping(value = "/managePage", method=RequestMethod.GET)
	public String managePage(HttpServletRequest request, HttpSession session) {
		User me = checkCookie(request, session);
		System.out.println(me);
		if(me != null) {
			ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
			ProductDAO productDAO = context.getBean("ProductJDBCTemplate", ProductJDBCTemplate.class);
			ArrayList<Product> products = productDAO.getByUserId(me.getId());
			session.setAttribute("products", products);
			return "manage";
		} else {
			return "index";
		}
	}

	@RequestMapping(value = "/aboutPage", method=RequestMethod.GET)
	public String aboutPage(HttpServletRequest request, HttpSession session) {
		checkCookie(request, session);
		return "about";
	}

	@RequestMapping(value = "/commodityPage", method=RequestMethod.GET)
	public String commodityPage(
			@RequestParam(name="keyword", required=true) String keyword,
			HttpServletRequest 	request,
			HttpSession 		session) {
		checkCookie(request, session);
		ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
		ProductDAO productDAO = context.getBean("ProductJDBCTemplate", ProductJDBCTemplate.class);
		ArrayList<Product> results = productDAO.searchProduct(keyword.split(" "));
		session.setAttribute("product", results);
		return "commodity";
	}

	@RequestMapping(value = "/addProductPage", method=RequestMethod.GET)
	public String addProductPage(HttpServletRequest request, HttpSession session) {
		User u = checkCookie(request, session);
		if(u != null) {
			return "addProduct";
		} else {
			return "index";
		}
	}
	
	@RequestMapping(value = "/detail", method=RequestMethod.GET)
	public String detailPage(
			@RequestParam(name="id", required=true) String id,
			HttpServletRequest 	request,
			HttpSession 		session) {
		checkCookie(request, session);
		ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
		UserDAO userDAO = context.getBean("UserJDBCTemplate", UserJDBCTemplate.class);
		ProductDAO productDAO = context.getBean("ProductJDBCTemplate", ProductJDBCTemplate.class);
		Product product = productDAO.getById(id);
		String userId = product.getUserId();
		User user = userDAO.getUserById(userId);
		
		session.setAttribute("product", product);
		session.setAttribute("user", user);
		return "details";
	}
	
	
	private User checkCookie(HttpServletRequest request, HttpSession session) {
		String id = CookieTools.getCookieId(request);
		if(id != null) {
			ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
			UserDAO userDAO = context.getBean("UserJDBCTemplate", UserJDBCTemplate.class);
			User u = userDAO.getUserById(id);
			session.setAttribute("me", u);
			return u;
		} 
		return null;
	}
	
	private boolean IsUserLogin(HttpServletRequest request) {
		return CookieTools.getCookieId(request) != null;
	}
}
