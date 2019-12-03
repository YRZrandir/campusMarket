package controller;

import java.io.IOException;
import java.util.ArrayList;

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

@Controller
public class PageController {
	
	
	@RequestMapping(value = "/loginPage", method=RequestMethod.GET)
	public String loginPage() {
		return "login";
	}

	@RequestMapping(value = "/index", method=RequestMethod.GET)
	public String indexPage() {
		return "index";
	}

	@RequestMapping(value = "/registerPage", method=RequestMethod.GET)
	public String registerPage() {
		return "register";
	}

	@RequestMapping(value = "/managePage", method=RequestMethod.GET)
	public String managePage() {
		return "manage";
	}

	@RequestMapping(value = "/aboutPage", method=RequestMethod.GET)
	public String aboutPage() {
		return "about";
	}

	@RequestMapping(value = "/commodityPage", method=RequestMethod.GET)
	public String commodityPage(@RequestParam(name="keyword", required=true) String keyword, HttpSession session) {
		ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
		ProductDAO productDAO = context.getBean("ProductJDBCTemplate", ProductJDBCTemplate.class);
		ArrayList<Product> results = productDAO.searchProduct(keyword.split(" "));
		session.setAttribute("product", results);
		return "commodity";
	}

	@RequestMapping(value = "/addProductPage", method=RequestMethod.GET)
	public String addProductPage() {
		return "addProduct";
	}
}
