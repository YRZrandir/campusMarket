package test;

import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import model.product.Product;
import model.product.ProductJDBCTemplate;
import model.user.User;
import model.user.UserJDBCTemplate;

public class test1 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

			// TODO Auto-generated method stub
		//product test
			String path = "src\\main\\webapp\\WEB-INF\\Beans.xml";
			FileSystemXmlApplicationContext context =new FileSystemXmlApplicationContext(path);
			ProductJDBCTemplate pt =(ProductJDBCTemplate)context.getBean("ProductJDBCTemplate");
//			Product p=pt.addProduct("3","3","3","2019-11-21 21:31:21","3", null);
//			System.out.println(p.toString());
			boolean p=pt.deleteProduct("20");
			System.out.println(p);
			
//user test
//		String path = "src\\main\\webapp\\WEB-INF\\Beans.xml";
//		FileSystemXmlApplicationContext context =new FileSystemXmlApplicationContext(path);
//		UserJDBCTemplate pt =(UserJDBCTemplate)context.getBean("UserJDBCTemplate");
//		User p=pt.addUser("201700305555","3","3",null,"SDU", "SE", null);
//		System.out.println(p.toString());

	}

}
