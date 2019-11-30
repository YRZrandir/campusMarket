package model.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;

public class ProductJDBCTemplate implements ProductDAO {

	private DriverManagerDataSource dataSource;
	public DriverManagerDataSource getDataSource() {
		return dataSource;
	}
	public void setDataSource(DriverManagerDataSource dataSource) {
		this.dataSource = dataSource;
		jdbcTemplateObject = new JdbcTemplate(dataSource);
	}
	//Auto injected, no need to initalize
	public JdbcTemplate getJdbcTemplateObject() {
		return jdbcTemplateObject;
	}
	public void setJdbcTemplateObject(JdbcTemplate jdbcTemplateObject) {
		this.jdbcTemplateObject = jdbcTemplateObject;
	}

	private JdbcTemplate jdbcTemplateObject;

	@Override
	public Product addProduct(String name, String userId, String price, String time, String description,
			String iconPath) {
		// TODO Auto-generated method stub
		String sql="insert into Product(pname,uid,price,time,description,iconPath) values (?,?,?,?,?,?)";
		GeneratedKeyHolder keyHolder=new GeneratedKeyHolder();
		jdbcTemplateObject.update(new PreparedStatementCreator() {

			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				// TODO Auto-generated method stub
				PreparedStatement pst=con.prepareStatement(sql,new String[] {"pid"});
				pst.setString(1, name);
				pst.setString(2, userId);
				pst.setString(3, price);
				pst.setString(4, time);
				pst.setString(5, description);
				pst.setString(6, iconPath);
				return pst;
			}
			
		},
				keyHolder);		
		Product p=new Product();
		p.setDescription(description);
		p.setIconPath(iconPath);
		p.setName(name);
		p.setTime(time);
		p.setUserId(userId);
		p.setPrice(price);
		p.setId(keyHolder.getKey().toString());
		return p;
	}

	@Override
	public boolean deleteProduct(String id) {
		// TODO Auto-generated method stub
		String sql="delete from Product where pid = "+id;

	    int count=jdbcTemplateObject.update(sql);
	    if(count!=0) {
	        return true;
	    }
	    return false;
	    
	}

	@Override
	public Product updateProduct(String id, String name, String userId, String price, String time, String description,
			String iconPath) {
		// TODO Auto-generated method stub
		String sql="update Product set (pname,uid,price,time,description,iconPath) = (?,?,?,?,?,?) where pid="+id;

		jdbcTemplateObject.update(new PreparedStatementCreator() {

			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				// TODO Auto-generated method stub
				PreparedStatement pst=con.prepareStatement(sql);
				pst.setString(1, name);
				pst.setString(2, userId);
				pst.setString(3, price);
				pst.setString(4, time);
				pst.setString(5, description);
				pst.setString(6, iconPath);
				return pst;
			}
			
		});		
		Product p=new Product();
		p.setDescription(description);
		p.setIconPath(iconPath);
		p.setName(name);
		p.setTime(time);
		p.setUserId(userId);
		p.setId(id);
		p.setPrice(price);
		return p;
	}

	@Override
	public ArrayList<Product> searchProduct(String name, String school, String campus) {
		// TODO Auto-generated method stub
		String sql="select * from Product natural join user where pname='"+name+"'"+"and school ='"+school+"' and campus ='"+campus+"'";

		
		 ArrayList<Product> list = (ArrayList<Product>) jdbcTemplateObject.query(sql, new RowMapper<Product>() {

				@Override
				public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
					// TODO Auto-generated method stub
					Product p=new Product();
					p.setDescription(rs.getString("description"));
					p.setIconPath(rs.getString("iconPath"));
					p.setName(rs.getString("pname"));
					p.setTime(rs.getString("time"));
					p.setUserId(rs.getString("uid"));
					p.setId(rs.getString("pid"));
					p.setPrice(rs.getString("price"));
					
					return p;
				}
				
				});
		return list;
	}


}
