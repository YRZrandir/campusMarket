package model.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.stereotype.Component;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;

@Component
public class ProductJDBCTemplate implements ProductDAO {

	@Autowired
	private DriverManagerDataSource dataSource;
	private JdbcTemplate jdbcTemplateObject;
	
	public DriverManagerDataSource getDataSource() {
		return dataSource;
	}
	public void setDataSource(DriverManagerDataSource dataSource) {
		this.dataSource = dataSource;
		jdbcTemplateObject = new JdbcTemplate(dataSource);
	}
	public JdbcTemplate getJdbcTemplateObject() {
		return jdbcTemplateObject;
	}
	public void setJdbcTemplateObject(JdbcTemplate jdbcTemplateObject) {
		this.jdbcTemplateObject = jdbcTemplateObject;
	}
	
	@Override
	public Product addProduct(String name, String userId, String price, String time, String description,
			String iconPath, String directory) {
		// TODO Auto-generated method stub
		String sql="insert into Product(name, userId, price, time, description, iconPath, status, directory) "
				+ " values (?,?,?,?,?,?,?,?)";
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
				pst.setString(7, "normal");
				pst.setString(8, directory);
				return pst;
			}
		},keyHolder);
		
		String id = keyHolder.getKey().toString();
		if(id == null) {
			return null;
		} else {
			return new Product(id, name, userId, price, time, description, iconPath, "normal", directory);
		}
	}

	@Override
	public boolean deleteProduct(String id) {
		// TODO Auto-generated method stub
		String sql="delete from Product where id = "+id;

	    int count=jdbcTemplateObject.update(sql);
	    if(count!=0) {
	        return true;
	    }
	    return false;
	    
	}

	@Override
	public boolean updateProduct(String id, String name, String price, String time, String description,
			String iconPath, String directory) {
		// TODO Auto-generated method stub
		String sql = String.format("update Product set "
				+ "name='%s', price='%s', time='%s', description='%s', directory='%s', iconPath='%s' "
				+ "where id='%s'",name, price, time, description, directory, iconPath, id);

		int ret = jdbcTemplateObject.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				// TODO Auto-generated method stub
				PreparedStatement pst=con.prepareStatement(sql);
				return pst;
			}
		});
		if(ret == 1) {
			return true;
		} else {
			return false;
		}
	}
	
	@Override
	public boolean updateProductKeepImage(String id, String name, String price,
			String time, String description, String directory) {
		String sql = String.format("update Product set "
				+ "name='%s', price='%s', time='%s', description='%s', directory='%s' "
				+ "where id='%s'",name, price, time, description, directory, id);

		int ret = jdbcTemplateObject.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				// TODO Auto-generated method stub
				PreparedStatement pst=con.prepareStatement(sql);
				return pst;
			}
		});		
		if(ret == 1) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public ArrayList<Product> searchProduct(String[] keywords) {
		// TODO Auto-generated method stub
		String sql="select * from product,user where product.userId=user.id and status='normal'";
		if(keywords.length != 0) {
			sql += " and (";
			for(int i = 0;i < keywords.length;i++) {
				String keyword = keywords[i];
				sql += " (product.name like '%" + keyword + "%' ";
				sql += " or school like '%" + keyword + "%' ";
				sql += " or campus like '%" + keyword + "%' ";
				sql += " or directory like '%" + keyword + "%' ";
				sql += " or description like '%" + keyword + "%' ";
				sql += " )";
				if (i < keywords.length - 1) {
					sql += " or ";
				}
			}
			sql += ")";
		}
		ArrayList<Product> list = (ArrayList<Product>) jdbcTemplateObject.query(sql, new RowMapper<Product>() {

				@Override
				public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
					// TODO Auto-generated method stub
					Product p=new Product();
					p.setDescription(rs.getString("description"));
					p.setIconPath(rs.getString("iconPath"));
					p.setName(rs.getString("name"));
					p.setTime(rs.getString("time"));
					p.setUserId(rs.getString("userId"));
					p.setId(rs.getString("id"));
					p.setPrice(rs.getString("price"));
					p.setDirectory(rs.getString("directory"));
					return p;
				}
				});
		return list;
	}

	
	public Product getById(String id) {
		// TODO Auto-generated method stub
		String sql="select * from Product where id ='" + id + "'";
		
		 ArrayList<Product> list = (ArrayList<Product>) jdbcTemplateObject.query(sql, new RowMapper<Product>() {
				@Override
				public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
					// TODO Auto-generated method stub
					Product p=new Product();
					p.setDescription(rs.getString("description"));
					p.setIconPath(rs.getString("iconPath"));
					p.setName(rs.getString("name"));
					p.setTime(rs.getString("time"));
					p.setUserId(rs.getString("userId"));
					p.setId(rs.getString("id"));
					p.setPrice(rs.getString("price"));
					p.setDirectory(rs.getString("directory"));
					return p;
				}
				});
		 if(list == null || list.isEmpty()) {
			 return null;
		 } else {
			 return list.get(0);
		 }
	}
	
	
	public ArrayList<Product> searchByDirectory(String directory) {
		// TODO Auto-generated method stub
		String sql="select * from Product where status='normal' and directory ='"+directory+"'";

		
		 ArrayList<Product> list = (ArrayList<Product>) jdbcTemplateObject.query(sql, new RowMapper<Product>() {

				@Override
				public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
					// TODO Auto-generated method stub
					Product p=new Product();
					p.setDescription(rs.getString("description"));
					p.setIconPath(rs.getString("iconPath"));
					p.setName(rs.getString("name"));
					p.setTime(rs.getString("time"));
					p.setUserId(rs.getString("userid"));
					p.setId(rs.getString("id"));
					p.setPrice(rs.getString("price"));
					p.setDirectory(rs.getString("directory"));
					return p;
				}
				
				});
		return list;
	}
	
	
	public ArrayList<Product> getAll() {
		// TODO Auto-generated method stub
		String sql="select * from Product where status='normal' order by time desc";

		 ArrayList<Product> list = (ArrayList<Product>) jdbcTemplateObject.query(sql, new RowMapper<Product>() {

				@Override
				public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
					// TODO Auto-generated method stub
					Product p=new Product();
					p.setDescription(rs.getString("description"));
					p.setIconPath(rs.getString("iconPath"));
					p.setName(rs.getString("name"));
					p.setTime(rs.getString("time"));
					p.setUserId(rs.getString("userid"));
					p.setId(rs.getString("id"));
					p.setPrice(rs.getString("price"));
					p.setDirectory(rs.getString("directory"));
					return p;
				}
				
				});
		return list;
	}

	public ArrayList<Product> getByUserId(String userId) {
		String sql="select * from Product where status='normal' and userId ='" + userId + "'";
		
		 ArrayList<Product> list = (ArrayList<Product>) jdbcTemplateObject.query(sql, new RowMapper<Product>() {

				@Override
				public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
					// TODO Auto-generated method stub
					Product p=new Product();
					p.setDescription(rs.getString("description"));
					p.setIconPath(rs.getString("iconPath"));
					p.setName(rs.getString("name"));
					p.setTime(rs.getString("time"));
					p.setUserId(rs.getString("userid"));
					p.setId(rs.getString("id"));
					p.setPrice(rs.getString("price"));
					p.setDirectory(rs.getString("directory"));
					return p;
				}
				
				});
		 return list;
	}
}
